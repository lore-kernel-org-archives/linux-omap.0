From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [ANNOUNCE] updated PM branch, based on 2.6.32-rc1
Date: Mon, 12 Oct 2009 13:47:29 -0700
Message-ID: <4AD395E1.9060105@deeprootsystems.com>
References: <87iqezdmas.fsf@deeprootsystems.com>	 <87eipgnmfh.fsf@deeprootsystems.com>	 <a46a26fd0910081509u426b0f9fraa24ea8c99a5717e@mail.gmail.com>	 <87ab014iun.fsf@deeprootsystems.com>	 <87bpkgwk3t.fsf@deeprootsystems.com>	 <87bpkgut1u.fsf@deeprootsystems.com>	 <87zl80te9t.fsf@deeprootsystems.com> <a46a26fd0910121137j6d86dfjf1df52612dcb88f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:63463 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbZJLUsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 16:48:43 -0400
Received: by pzk26 with SMTP id 26so8351686pzk.4
        for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 13:47:31 -0700 (PDT)
In-Reply-To: <a46a26fd0910121137j6d86dfjf1df52612dcb88f1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: linux-omap@vger.kernel.org

Juha Kuikka wrote:
[...]

> 
> I updated both x-loader and u-boot. And I also pulled the latest
> omap-pm and did a fresh build. I noticed there is a commit that should
> fix the serial port issue.
> 
> Unfortunately I am still plagued by it.
> 
> X-Loader 1.41
> U-Boot 2009.08 (Oct 09 2009 - 15:59:45)
> Latest omap-om git pull (b7ecc865c5f0885fae4c4401fa78a24084f45c40).
> 

That's the latest commit.

But I haven't (intentionally) pushed anything to fix that serial issue 
yet.  Which commit are you referring to that should fix the issue?

Kevin
