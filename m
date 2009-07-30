From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: Re: OMAP3 EHCI USB on Beagleboard
Date: Thu, 30 Jul 2009 14:29:53 -0700
Message-ID: <dfb660300907301429o484d808bp5c3ff2c54b307db1@mail.gmail.com>
References: <dfb660300907301336i1b1c196dpbd390961370ecd05@mail.gmail.com>
	 <bb2708720907301402x78834952oa1040c281044d908@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f200.google.com ([209.85.222.200]:49939 "EHLO
	mail-pz0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbZG3V3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jul 2009 17:29:53 -0400
Received: by pzk38 with SMTP id 38so672261pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 30 Jul 2009 14:29:54 -0700 (PDT)
In-Reply-To: <bb2708720907301402x78834952oa1040c281044d908@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Sarman <johnsarman@gmail.com>, linux-omap@vger.kernel.org

On Thu, Jul 30, 2009 at 2:02 PM, John Sarman<johnsarman@gmail.com> wrote:
> On Thu, Jul 30, 2009 at 4:36 PM, Laine Walker-Avina<lwalkera@ieee.org> wrote:
>> Hi,
>>
>> I've been trying to get the EHCI USB host port on the beagleboard to
>> work but with little success. The board initial finds the usb devices
>> plugged into a hub on boot, but once I'm able to login, I get a
>> disconnect notice on the hub and the port will no longer recognize any
>> usb device inserted until reboot. Any ideas what's going on? I'm using
>> the current master branch of the omap git repo.
>
> Do you have it connected to an external self powered USB hub, or
> direct connect ?
> Also is it a high spped device, I think the transaction translator can
> only support high speed, but have not verified that.
>
>>
>> Thanks,
>> Laine Walker-Avina

It's a high speed, self-powered hub, with various devices connected.

-Laine
