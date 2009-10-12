From: Juha Kuikka <juha.kuikka@gmail.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Mon, 12 Oct 2009 13:57:13 -0700
Message-ID: <a46a26fd0910121357t314d186aw63d31ac3e5ca3990@mail.gmail.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
	 <87eipgnmfh.fsf@deeprootsystems.com>
	 <a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>
	 <87ab014iun.fsf@deeprootsystems.com>
	 <87bpkgwk3t.fsf@deeprootsystems.com>
	 <87bpkgut1u.fsf@deeprootsystems.com>
	 <87zl80te9t.fsf@deeprootsystems.com>
	 <a46a26fd0910121137j6d86dfjf1df52612dcb88f1@mail.gmail.com>
	 <4AD395E1.9060105@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f186.google.com ([209.85.221.186]:53328 "EHLO
	mail-qy0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbZJLU5u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 16:57:50 -0400
Received: by qyk16 with SMTP id 16so2669870qyk.15
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 13:57:13 -0700 (PDT)
In-Reply-To: <4AD395E1.9060105@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mon, Oct 12, 2009 at 1:47 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Juha Kuikka wrote:
> [...]
>
>>
>> I updated both x-loader and u-boot. And I also pulled the latest
>> omap-pm and did a fresh build. I noticed there is a commit that shou=
ld
>> fix the serial port issue.
>>
>> Unfortunately I am still plagued by it.
>>
>> X-Loader 1.41
>> U-Boot 2009.08 (Oct 09 2009 - 15:59:45)
>> Latest omap-om git pull (b7ecc865c5f0885fae4c4401fa78a24084f45c40).
>>
>
> That's the latest commit.
>
> But I haven't (intentionally) pushed anything to fix that serial issu=
e yet.
> =A0Which commit are you referring to that should fix the issue?
>
This one:
http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git;a=
=3Dcommit;h=3D6ef4035c4a04bab8d94d8b80fcb90ea7230b8126

Committed 5 days ago. It looked like it might have something to do with=
 this.

My bad. Please ignore the noise.

Juha
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
