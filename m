From: tarek attia <tarek.m.attia@gmail.com>
Subject: Re: ACPI notifier chain?
Date: Tue, 1 Dec 2009 13:42:57 +0200
Message-ID: <82cfbe860912010342y3842340dk634427d26c341eaf@mail.gmail.com>
References: <82cfbe860912010053s54ab1c51wfa3400fb9d0d7c89@mail.gmail.com>
	 <1259661503.1969.1.camel@sanganak>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64672 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZLALmw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Dec 2009 06:42:52 -0500
Received: by ewy19 with SMTP id 19so4817700ewy.21
        for <linux-omap@vger.kernel.org>; Tue, 01 Dec 2009 03:42:57 -0800 (PST)
In-Reply-To: <1259661503.1969.1.camel@sanganak>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi Ameya,

I believe ACPI is a standard that doesn't matter it's X86 or ARM ,and
it's responsible for power states (S,C,D and P states) ,,and Linux
kernel implemented this standard .

Am I right ??

BTW :- if it's not like so,,How can I monitor the power changes on the
peripherals like LCD connected to my beagleboard ??

How can I make the power management  for the peripherals ??

On Tue, Dec 1, 2009 at 11:58 AM, Ameya Palande <ameya.palande@nokia.com> wrote:
> Hi Tarek,
>
> On Tue, 2009-12-01 at 09:53 +0100, ext tarek attia wrote:
>> Hi all,
>>
>> Can I use the ACPI notifier chain to get noticed when any change for
>> any peripheral has been occurred ?
>>
>> Like the Video dimming ,can I make a Linux driver module to get
>> informed once any change has been occurred to it??
>>
>>
>>
>> Regards,
>>
>> tarek
>
> I believe ACPI is x86 architecture specific thing. I don't think it has
> anything to do with ARM / OMAP.
>
> Cheers,
> Ameya.
>
>
