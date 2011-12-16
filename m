From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] ASoC: OMAP: HDMI: Prevent DSS module from going idle
 when playing audio
Date: Fri, 16 Dec 2011 02:09:00 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1112160151330.12660@utopia.booyaka.com>
References: <1324019032-31532-1-git-send-email-ricardo.neri@ti.com>  <alpine.DEB.2.00.1112160107380.12660@utopia.booyaka.com>  <1324023504.1859.11.camel@deskari>  <alpine.DEB.2.00.1112160121250.12660@utopia.booyaka.com> <1324025267.1859.29.camel@deskari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-748580774-1324026540=:12660"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40133 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760298Ab1LPJJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Dec 2011 04:09:02 -0500
In-Reply-To: <1324025267.1859.29.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>, b-cousson@ti.com, linux-omap@vger.kernel.org, mythripk@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-748580774-1324026540=:12660
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Dec 2011, Tomi Valkeinen wrote:

> Ricardo, struct omap_dss_board_info already contains a few function
> pointers, for example get_context_loss_count. I think
> omap_hwmod_set_slave_idlemode can be handled the same way.
>=20
> Although I'm not sure should the function pointer be just
> "set_slave_idlemode", and thus just a direct way to call the hwmod func,
> or should it be something more use case specific, like, say
> "hdmi_audio_start/stop".
>=20
> I'm thinking it should be the latter. As far as I understand, the bug is
> not in the HDMI IP, but somewhere in the L3 side? And if so, it's not
> the HDMI driver's job to know how to fix the bug, but just to offer
> hooks so that the platform code can fix it.

Should the HDMI module ever be allowed to run in smart-idle wakeup mode=20
while it's active?  If not, then the easy way to fix this bug would be to=
=20
add the HWMOD_SWSUP_SIDLE flag to the HDMI omap_hwmod.flags field.  No=20
omap_device/omap_hwmod code/pdata hacking needed.

On the other hand, if there are times when the HDMI module should run in=20
smart-idle wakeup while it's active, then some code would be needed. =20
It's ironic that the bug is related to L3 interface clock autoidle, but=20
that we no longer have the ability to control that on OMAP4...  My=20
recollection is that the McBSP + sidetone blocks have exactly the same bug=
=20
on OMAP3, but that case is even worse because they can't use the module=20
slave idle bits to fix the problem due to some power management=20
regression.

So anyway, off the top of my head, I'd na=C3=AFvely suggest something like=
=20
omap_hwmod_block_slave_autoidle() and omap_hwmod_allow_slave_autoidle(). =
=20
I don't think we'd have a situation where we'd need to use-count these,=20
unless you think otherwise.  So I'd suggest having those functions do=20
nothing if HWMOD_SWSUP_SIDLE is set in omap_hwmod.flags.  Otherwise, I'd=20
suggest that block() should set a new omap_hwmod._int_flags bit,=20
_HWMOD_SWSUP_SIDLE_FORCE or something, and call _set_slave_idlemode()=20
appropriately.  allow() should clear that flag and call=20
_set_slave_idlemode() appropriately.  It will also be necessary to change=
=20
every place in the hwmod code that tests omap_hwmod.flags against=20
HWMOD_SWSUP_SIDLE to also test omap_hwmod._int_flags against=20
_HWMOD_SWSUP_SIDLE_FORCE, e.g., in _{enable,disable}_wakeup(),=20
_{enable,idle}_sysc(), etc.

Thoughts welcome.

- Paul
--155748971-748580774-1324026540=:12660--
