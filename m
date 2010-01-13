From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [alsa-devel] Audio suspend/resume status on OMAP3 based platforms
Date: Wed, 13 Jan 2010 09:10:04 +0200
Message-ID: <201001130910.04292.peter.ujfalusi@nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:51862 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab0AMHKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 02:10:30 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E1D7807@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tuesday 12 January 2010 18:05:15 ext Aggarwal, Anuj wrote:
> Hi,
>=20
> I want to check the status of suspend/resume functionality when audio
> subsystem is being used. Specifically, has some one tried the followi=
ng
> tests on their omap3 based platforms:
>=20
> a) echo mem > /sys/power/state, when audio playback is running in
> background
> b) same command, when audio capture is running in
> background
> b) same command, when audio loopback is running in
> background
>=20
> I am facing some issues with (b) & (c) so wanted to confirm whether
> someone else has faced similar problem or not.

As Jarkko pointed out in a separate mail, we should not expect the=20
suspend/resume to be working correctly until the context save/restore, =
and the=20
clock management is sorted out.

On the other hand it seams that the problem is in the capture path (b a=
nd c=20
having issues).

How is the McBSP configured in your setup (master or slave)?
I think we might have different issues with suspend/resume when OMAP Mc=
BSP is=20
slave or if it is master.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
