From: Tar Gz <bsdraisefromhell@gmail.com>
Subject: Re: [help] 2.6.30 can't booting
Date: Tue, 18 Aug 2009 04:59:26 -0700
Message-ID: <d9ca78710908180459w2a3521d4h979da6f4299f5b11@mail.gmail.com>
References: <d9ca78710908160948y246fa71epd564903d7fbbddbb@mail.gmail.com>
	 <d9ca78710908161031s7f19ea94j61cb6ae849664168@mail.gmail.com>
	 <4A884705.1060905@holografika.com>
	 <d9ca78710908161055t548d0964l92b9e47d5bd693f7@mail.gmail.com>
	 <d9ca78710908161101n4e2420b6xba6665e5c5d8cc21@mail.gmail.com>
	 <4A886017.1040004@holografika.com>
	 <d9ca78710908161512i324875e1md13a69da68edab73@mail.gmail.com>
	 <4A890921.2080201@holografika.com>
	 <d9ca78710908180447p3a90792ag374d244b1bf328cc@mail.gmail.com>
	 <d9ca78710908180458n7d38dceeq8877ca53e7fb64bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f205.google.com ([209.85.217.205]:33936 "EHLO
	mail-gx0-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758576AbZHRL7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Aug 2009 07:59:25 -0400
Received: by gxk1 with SMTP id 1so4914101gxk.17
        for <linux-omap@vger.kernel.org>; Tue, 18 Aug 2009 04:59:26 -0700 (PDT)
In-Reply-To: <d9ca78710908180458n7d38dceeq8877ca53e7fb64bf@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kovacs Peter Tamas <p.kovacs@holografika.com>, linux-omap <linux-omap@vger.kernel.org>

if i'm using another partition?..how i mount partition that?

On 8/18/09, Tar Gz <bsdraisefromhell@gmail.com> wrote:
> ---------- Forwarded message ----------
> From: Tar Gz <bsdraisefromhell@gmail.com>
> Date: Tue, 18 Aug 2009 04:47:21 -0700
> Subject: Re: [help] 2.6.30 can't booting
> To: Kovacs Peter Tamas <p.kovacs@holografika.com>, linux-omap
> <linux-omap@vger.kernel.org>
>
> On 8/17/09, Kovacs Peter Tamas <p.kovacs@holografika.com> wrote:
>> Hi,
>>
>> we use these parameters for NFS booting:
>> setenv bootargs console=ttyS2,115200n8 noinitrd root=/dev/nfs rw
>> nfsroot=10.95.102.32:/home/filesystems/tifs,nolock,vers=3,rsize=2048,wsize=2048,
>> tcp dyntick=e ip=dhcp nohz=off
>>
>> or without DHCP:
>> setenv bootargs console=ttyS2,115200n8 noinitrd,rw root=/dev/nfs
>> nfsroot=10.95.102.32:/home/filesystems/tifs,nolock, mem=112M nohz=off
>> ip=10.95.102.33:10.95.96.1:10.95.96.1:255.255.240.0:infba00798::off
>> devfs=mount
>>
>
> oke i try it....
>
> in the another mailing list, the problem about different speed
> bootloader and linux kernel..if that's my problem..how i can fix
> that?....thanks before
>
> Regards,
> Aldyth M
>
