From: Tony Lindgren <tony@atomide.com>
Subject: Re: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
Date: Sat, 7 Dec 2013 13:11:37 -0800
Message-ID: <20131207211137.GR26766@atomide.com>
References: <20131206213613.GA19648@earth.universe>
 <201312070918.32471@pali>
 <20131207134818.GA933@earth.universe>
 <201312071457.38836@pali>
 <20131207165104.GD11015@atomide.com>
 <20131207184958.GB3704@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21041 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754375Ab3LGVLk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Dec 2013 16:11:40 -0500
Content-Disposition: inline
In-Reply-To: <20131207184958.GB3704@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Joel Fernandes <joelf@ti.com>

* Sebastian Reichel <sre@ring0.de> [131207 10:51]:
> On Sat, Dec 07, 2013 at 08:51:04AM -0800, Tony Lindgren wrote:
> > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [131207 05:58]:
> > > On Saturday 07 December 2013 14:48:20 Sebastian Reichel wrote:
> > > > On Sat, Dec 07, 2013 at 09:18:32AM +0100, Pali Roh=C3=A1r wrote=
:
> > > > > On Saturday 07 December 2013 01:00:27 Sebastian Reichel=20
> > > wrote:
> > > > > > On Fri, Dec 06, 2013 at 02:27:25PM -0800, Tony Lindgren=20
> > > wrote:
> > > > > > > * Sebastian Reichel <sre@debian.org> [131206 13:37]:
> > > > > > > > Nokia N900 DT boot breaks for me using 3.13-rc3. You
> > > > > > > > can see the relevant kernel output below. Disabling
> > > > > > > > the AES module in the omap3-n900.dts with status =3D
> > > > > > > > "disabled" fixed the boot for me.
> > > > > > >=20
> > > > > > > OK thanks for letting me know. How about the following
> > > > > > > patch to fix it?
> > > > > >=20
> > > > > > That's basically what I did to fix the problem.
> > > > > >=20
> > > > > > I guess the proper fix would be a runtime check if the
> > > > > > device can be accessed (if that's possible). AFAIK it is
> > > > > > possible to use the AES module on the N900 if the
> > > > > > bootloader is slightly patched.
> > > > > >=20
> > > > > > Pali, can you elaborate more about this? I've seen, that
> > > > > > you added a section about this on [0].
> > > > > >=20
> > > > > > [0] http://elinux.org/N900#M-Shield
> > > > > >=20
> > > > > > -- Sebastian
> > > > >=20
> > > > > Yes, if you want to use M-Shield on Nokia N900, you need to
> > > > > use new version of signed Nokia X-Loader which enable
> > > > > M-Shield usage outside secure world.
> > > > >=20
> > > > > Because this updated X-Loader is not official and I think
> > > > > nobody has it in n900, please disable using these M-Shield
> > > > > crypto modules on n900.
> > > >=20
> > > > Is the updated X-Loader available somewhere?
> > > >=20
> > >=20
> > > It was on mediafire server linked from this thread:=20
> > > http://maemo.org/community/maemo-developers/n900_aes_and_sha1-md5=
_hw_acceleration_drivers/
> > >
> > > Now it is deleted from that server, but I have copy on my HDD.
> >=20
> > Hmm OK let's hope there's some working link still around for those.
> > It seems like we should eventually cover both options, but for
> > the -rc cycle, we need to just disable those hardware modules in
> > the .dtsi files.
>=20
> Yes. I think for -rc cycle disabling the AES module is the right
> way. It has been disabled before anyway. I will test your patch
> later.

OK thanks.
=20
> > I think we can check the configuration from the L3 registers.
> > Looks like we no longer have those defined after purging the
> > unused defines a while back, but I think the registers for the
> > configuration are L3_PM_READ_PERMISSION etc registers.
>=20
> I asked Pali to send me his copy of the updated NOLO bootloader,
> so that I can test this. I just checked the omap documentation
> (I only have access to the public one) and crypto related stuff
> is not documented for the L3_PM_READ_PERMISSION register. There
> are a couple of reserved bits, which may be used for this, though.
>=20
> I also CC'd Joel Fernandes, since he worked on the driver before and
> may have access to the documentation.

Looks like at least the 36xx public version referenced here has them:

http://www.spinics.net/lists/linux-omap/msg21857.html

I'd assume the registers are the same for 34xx since we don't have
them defined separately in the kernel.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
