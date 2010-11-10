From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: BeagleBoard not resuming from uart with latest pm-core ?
Date: Wed, 10 Nov 2010 17:07:08 +0100
Message-ID: <AANLkTi=Dzv2XE-X_z6yiCaRjgWrST5QGDE9dFDnDy9pT@mail.gmail.com>
References: <20101110164414.4529cbda@surf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36545 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756488Ab0KJQHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Nov 2010 11:07:10 -0500
Received: by qwi4 with SMTP id 4so595477qwi.19
        for <linux-omap@vger.kernel.org>; Wed, 10 Nov 2010 08:07:10 -0800 (PST)
In-Reply-To: <20101110164414.4529cbda@surf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: linux-omap@vger.kernel.org

Hi Thomas,

l-o is currently broken wrt to suspend and idle.
Solutions are being worked on for the moment.

Kevin, are there solutions available yet?

Regards,
Jean

On Wed, Nov 10, 2010 at 4:44 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> Hello,
>
> I've updated my tree to the last pm-core branch today (I'm at commit
> 42289e226ec996a13ab8a2aaef5ad9dda61ee57e), and I've built the
> omap2plus_defconfig with no change (except adding an initramfs). On m=
y
> BeagleBoard, I enable the wakeup from UART
> in /sys/devices/platform/omap/omap-hsuart.2/tty/ttyO2/power/wakeup,
> then trigger suspend to RAM. It enters suspend to RAM, but then
> it doesn't wakeup when I send data through the UART.
>
> Is it a known problem, or is again a mistake on my side ?
>
> Thanks,
>
> Thomas
> --
> Thomas Petazzoni, Free Electrons
> Kernel, drivers, real-time and embedded Linux
> development, consulting, training and support.
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
