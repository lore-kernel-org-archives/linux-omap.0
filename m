From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 12/12] OMAPDSS: DPI: always use DSI PLL if available
Date: Wed, 7 Nov 2012 17:13:25 +0200
Message-ID: <509A7A95.804@ti.com>
References: <1351613409-21186-1-git-send-email-tomi.valkeinen@ti.com> <1351613409-21186-13-git-send-email-tomi.valkeinen@ti.com> <5090D28E.6050703@ti.com> <50939B84.6090602@ti.com> <5093A3FB.1060806@ti.com> <5093A530.5050302@ti.com> <5093A9E8.70106@ti.com> <5093AE79.9010603@ti.com> <5093B4F3.1000703@ti.com> <50977EEF.3040403@ti.com> <5097CB81.7050204@ti.com> <509913A4.5080408@iki.fi> <CAF6AEGuNyqO-teda1sv8c8m9x1j8Fm13HYuWB4N3gccJeKFTFg@mail.gmail.com> <509A3171.8010100@ti.com> <CAF6AEGvJqmvkvkbnegVvnt+SxrWajB=Vq-LsY=k1c96eeyQEXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40739683CF20484773B4F7D5"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52103 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751492Ab2KGPNj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 10:13:39 -0500
In-Reply-To: <CAF6AEGvJqmvkvkbnegVvnt+SxrWajB=Vq-LsY=k1c96eeyQEXA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Clark <rob.clark@linaro.org>
Cc: Tomi Valkeinen <tomba@iki.fi>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enig40739683CF20484773B4F7D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-07 16:32, Rob Clark wrote:
> On Wed, Nov 7, 2012 at 4:01 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> =
wrote:

>> Hotplugging is not some abstract future scenario, we already have
>> hardware that could use it. For example, omap3 SDP board has a
>> switchable output to DVI or LCD panel. In this case we know what the t=
wo
>> options are, but the disabled component is still effectually removed
>> from the system, and plugged back in when it's enabled.
>=20
> I would look at this as two different connectors which can not be used
> at the same time.  You have this scenario with desktop graphics cards.

Yes, that's an option with fixed amount of display devices. But doesn't
work for capes.

>> Hotplug is not a high priority item, but I do wish we get it supported=

>> in common panel framework. Then it's at least possible to extend drm i=
n
>> the future to support it.
>>
>>
>>
>> Anyway, this makes me wonder... omapdrm currently maps the elements of=

>> the whole video pipeline to drm elements (encoder, connector, etc).
>> Would it make more sense to just map the DISPC to these drm elements?
>> Connector would then be the output from DISPC.
>=20
> I think:
>=20
>   plane->overlay
>   crtc->manager
>=20
> is pretty clear.  And really
>=20
>   encoder->output
>=20
> should be the way it is..  on the branch w/ omapdss/omapdrm kms

I'm not so sure. The output (dpi/dsi/hdmi...) is the second step in our
chain. The primary "output" is in the DISPC module, the overlay manager.
That's where the timings, pixel clock, etc. are programmed. The second
step, our output, is really a converter IP. It receives the primary
output, converts it and outputs something else. Just like an external
converter chip would do.

And the output can be quite a bit anything. For example, with DBI or DSI
command mode outputs we don't have any of the conventional video
timings. It doesn't make sense to program, say, video blanking periods
to those outputs. But even with DBI and DSI we do have video blanking
periods in the DISPC's output, the ovl mgr.

Of course, at the end of the chain we have a panel that uses normal
video timings (well, most likely but not necessarily), and so we could
program those timings at the end of the chain, in the block before the
panel. But even then the encoder doesn't really map to the DSS's output
block, as the DSS's output block may not have the conventional timings
(like DBI), or they may be something totally different than what we get
in the end of the chain to the panel.

So I think mapping encoder to output will not work with multiple display
blocks in a chain. Thus I'd see the encoder would better match the
DISPC's output, or alternatively perhaps the block which is just before
the panel (whatever that is, sometimes it can be OMAP's DSI/HDMI/etc).
However, the latter may be a bit strange as the block could be an
external component, possibly hotpluggable.

> re-write, this is how it is for plane/crtc, except for now:
>=20
>   encoder+connector->dssdev
>=20
> Basically the encoder is doing the "control" stuff (power on/off, set
> timings, etc), and the connector is only doing non control stuff
> (detect, reading edid, etc).
>=20
> But I think this will probably change a bit as CFP comes into the
> picture.  Currently the drm connector is somewhat a "passive" element,
> but I think this will have to change a bit w/ CFP.
>=20
>> This would map the drm elements to the static hardware blocks, and the=

>> meaning of those blocks would be quite similar to what they are in the=

>> desktop world (I guess).
>>
>> The panel driver, the external chips, and the DSS internal output bloc=
ks
>> (dsi, dpi, ...) would be handled separately from those drm elements. T=
he
>> DSS internal blocks are static, of course, but they can be effectively=

>> considered the same way as external chips.
>=20
> I think dsi/dpi/etc map to encoder.  The big question is where the
> panel's fit.  But to userspace somehow this should look like
> connectors.  I think:
>=20
>   encoder->output
>   connector->panel
>=20
> could work.. although connector is less passive than KMS currently
> assumes.  And "panel" could really be a whole chain in the case of
> bridge chips, etc.  I don't know, maybe there are better ways.  But I
> think userspace really just wants to know "which monitor" which is
> basically connector.

Hmm yes. Well, even if we map encoder and connector to the ovl manager,
the userspace could see which monitor there is. Obviously we need to
make changes for that to work, but as a model it feels a lot more
natural to me than using output and panel for encoder and connector.

Perhaps it's wrong to say "map connector to ovl mgr". It would be more
like "this connector observes the chain connected to this ovl mgr", even
though the connector wouldn't observe any block in the chain directly.
Just observing the plug in/out status, etc.

But I think encoder really maps quite well directly to the output side
of overlay manager.

>> The omapdrm driver needs of course to access those separate elements
>> also, but that shouldn't be a problem. If omapdrm needs to call a
>> function in the panel driver, all it needs to do is go through the cha=
in
>> to find the panel. Well, except if one output connected two two panels=

>> via a bridge chip...
>=20
> yeah, that is a really ugly case in our hw since it is quite
> non-transparent (ie. implications about use of planes, etc).

Not really in this case. You're perhaps thinking about connecting two
outputs to a single panel. Which is problematic also.

We don't have in sights a board that splits one output to two panels, so
I think we should just ignore that for now. But two outputs for one
panel is on the table.

>> And if drm is at some point extended to support panel drivers, or chai=
ns
>> of external display entities, it would be easier to add that support.
>>
>> What would it require the manage the elements like that? Would it help=
?
>> It sounds to me that this would simplify the model.
>=20
> I'm not really entirely sure..  other than at least other drivers
> supporting CFP will have the same requirements ;-)
>=20
> I guess the two best options are either bury some sort of chain of
> panel drivers in the connector, or introduce some internal elements in
> DRM which are not necessarily visible to userspace.  (Or at least
> userspace should have the option to ignore it for backwards
> compatibility.  For atomic pageflip/modeset, the converting of
> everything to properties makes it easier to think about exposing new
> KMS mode object types to userspace.)

Yes, I don't think we should or need to expose these new elements to
userspace, at least in the first place.

 Tomi



--------------enig40739683CF20484773B4F7D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQmnqWAAoJEPo9qoy8lh7188oP/1s97d4SrxBCMV2HfbckAFu3
mSoWpWj81AmlhuadlfjZW2rLOwEQFo9soYXxZ6sKuy42Z6NjxO/RZ5LcS/masyFV
4s9ewzXl+/Gl4hOVtt7dpaQs/VxbhCwykLAO+cmM5nz7aX22o6ojTC5spZhyiO3v
2hXR7i4TXzhc32O14xZByHl1fQNLnrmS1Q4EqD11dlW6IaDK6OZRhww2cNasCQGO
0hrJHLAt33PnfpWXRdZOWFkcQlw6azkQx8aECCNpqchfr26ShIgPVKPfw7vh75bx
KwDQWLuN5cVUK33ymQMzOWO5/bWcrWHC4irdlIIJfPx7elzpje5Wdkdi2+ao/EwU
Sw/u3OSwd3//wIjONpapCSt0KspOyla1YTx12hgZ/CXO/HmGBe4yfm9LZepZCJJc
sOPAFbl/bTueiSX0PqFXfTnli3HwKtqkabqGFQ691Bfda1V2e8GWnAIBO7hXkasi
KkQHqM1J7JNW9UiAUakI5pq5mcXyTP4wRFAc98wkkXaJzWB8J7M2QEBbvjFFXJEd
G5G3CuY2iltBYUdkbnDPR+UfIibEOTqoaCGwcg/hyTdg25SzRfeK7yWnKPrYwwSw
Y+H6aApuYzv9gL5miEfKTTS/mJoKcCh/gP7IINXwy9nge+RhwpwRB4dAWyhmGWbB
M8IBQxFkW//pwYt4rAMG
=4k8j
-----END PGP SIGNATURE-----

--------------enig40739683CF20484773B4F7D5--
