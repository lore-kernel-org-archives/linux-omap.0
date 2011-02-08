From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2] ARM: Define wfi() macro for v6 processors
Date: Tue, 8 Feb 2011 16:31:02 +0000
Message-ID: <AANLkTinD=jVXWdzH_LwbFy=En3LYrZ-Byu0JiFDAxNxd@mail.gmail.com>
References: <1297162885-2975-1-git-send-email-dave.martin@linaro.org>
	<201102081353.20390.arnd@arndb.de>
	<AANLkTi=+2VN53gs=ZDr-M0V3mG5A0iMPRL-RdUugXxUy@mail.gmail.com>
	<201102081615.15713.arnd@arndb.de>
	<20110208162515.GB6188@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53563 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab1BHQbD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 11:31:03 -0500
Received: by eye27 with SMTP id 27so3062415eye.19
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 08:31:02 -0800 (PST)
In-Reply-To: <20110208162515.GB6188@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Tue, Feb 8, 2011 at 4:25 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Feb 08, 2011 at 04:15:15PM +0100, Arnd Bergmann wrote:
>> But that doesn't work if you build a combined v5/v6/v7 kernel, becau=
se
>> v5 supports neither form, right? I think to do that, it needs the
>> same kind of abstraction that we have for a number of other things
>> like cache management in arch/arm/mm/.
>
> The options are kernels which support v3-v5 or v6-v7. =A0There's too =
big
> a change between v5 and v6 to combine those into one kernel.
>

Indeed... wfi() is a good example of where being generic gets hard...
some v5 processors (typically those with caches) implement the same
MCR supported by v6, but it's not universal.  Typically v4 processors
have no WFI capability.

---Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
