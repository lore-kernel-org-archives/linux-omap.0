From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: ACPI notifier chain?
Date: Tue, 01 Dec 2009 15:18:39 +0200
Message-ID: <1259673519.1969.50.camel@sanganak>
References: <82cfbe860912010053s54ab1c51wfa3400fb9d0d7c89@mail.gmail.com>
	 <1259661503.1969.1.camel@sanganak>
	 <82cfbe860912010342y3842340dk634427d26c341eaf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:21926 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbZLANSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 08:18:55 -0500
In-Reply-To: <82cfbe860912010342y3842340dk634427d26c341eaf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext tarek attia <tarek.m.attia@gmail.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Tarek,

On Tue, 2009-12-01 at 12:42 +0100, ext tarek attia wrote:
> Hi Ameya,
> 
> I believe ACPI is a standard that doesn't matter it's X86 or ARM ,and
> it's responsible for power states (S,C,D and P states) ,,and Linux
> kernel implemented this standard .
> 
> Am I right ??

You are absolutely right :) It is a specification which can be
implemented by a hardware. I think the hardware which supports ACPI is
mostly i386, x86_64, and ia64.

Also you can see that from drivers/acpi/Kconfig that linux acpi depends
on above mentioned hardware.

#
# ACPI Configuration
#

menuconfig ACPI
        bool "ACPI (Advanced Configuration and Power Interface) Support"
        depends on !IA64_HP_SIM
        depends on IA64 || X86
        depends on PCI
        depends on PM

> BTW :- if it's not like so,,How can I monitor the power changes on the
> peripherals like LCD connected to my beagleboard ??
> 
> How can I make the power management  for the peripherals ??

I am not an expert in PM area. But may be this will be helpful:
http://elinux.org/OMAP_Power_Management

Cheers,
Ameya.

