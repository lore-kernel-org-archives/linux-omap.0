From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Mon, 12 Oct 2009 14:27:22 -0700
Message-ID: <87ws30qp51.fsf@deeprootsystems.com>
References: <87iqezdmas.fsf@deeprootsystems.com>
	<87eipgnmfh.fsf@deeprootsystems.com>
	<a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>
	<87ab014iun.fsf@deeprootsystems.com>
	<87bpkgwk3t.fsf@deeprootsystems.com>
	<87bpkgut1u.fsf@deeprootsystems.com>
	<87zl80te9t.fsf@deeprootsystems.com>
	<a46a26fd0910121137j6d86dfjf1df52612dcb88f1@mail.gmail.com>
	<4AD395E1.9060105@deeprootsystems.com>
	<a46a26fd0910121357t314d186aw63d31ac3e5ca3990@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f187.google.com ([209.85.216.187]:59857 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757294AbZJLV2I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 17:28:08 -0400
Received: by pxi17 with SMTP id 17so11464468pxi.21
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 14:27:32 -0700 (PDT)
In-Reply-To: <a46a26fd0910121357t314d186aw63d31ac3e5ca3990@mail.gmail.com> (Juha Kuikka's message of "Mon\, 12 Oct 2009 13\:57\:13 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap@vger.kernel.org

Juha Kuikka <juha.kuikka@gmail.com> writes:

> On Mon, Oct 12, 2009 at 1:47 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Juha Kuikka wrote:
>> [...]
>>
>>>
>>> I updated both x-loader and u-boot. And I also pulled the latest
>>> omap-pm and did a fresh build. I noticed there is a commit that sho=
uld
>>> fix the serial port issue.
>>>
>>> Unfortunately I am still plagued by it.
>>>
>>> X-Loader 1.41
>>> U-Boot 2009.08 (Oct 09 2009 - 15:59:45)
>>> Latest omap-om git pull (b7ecc865c5f0885fae4c4401fa78a24084f45c40).
>>>
>>
>> That's the latest commit.
>>
>> But I haven't (intentionally) pushed anything to fix that serial iss=
ue yet.
>> =A0Which commit are you referring to that should fix the issue?
>>
> This one:
> http://git.kernel.org/?p=3Dlinux/kernel/git/khilman/linux-omap-pm.git=
;a=3Dcommit;h=3D6ef4035c4a04bab8d94d8b80fcb90ea7230b8126
>
> Committed 5 days ago. It looked like it might have something to do wi=
th this.

Yeah, commited 5 days ago due to me rebasing, but if you look at the
author date it's from a while back.

> My bad. Please ignore the noise.

No worries.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
