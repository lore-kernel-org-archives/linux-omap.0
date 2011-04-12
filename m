From: Vladimir Pantelic <vladoman@gmail.com>
Subject: Re: OMAP_DSS: DSI driver with support for video mode?
Date: Tue, 12 Apr 2011 09:01:53 +0200
Message-ID: <4DA3F8E1.5010504@gmail.com>
References: <BANLkTi=ca5GYo1p-GT27B0Uq3RcUtDuakQ@mail.gmail.com> <4DA3DE55.1080704@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58921 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754215Ab1DLHB5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Apr 2011 03:01:57 -0400
Received: by fxm17 with SMTP id 17so4080463fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 00:01:55 -0700 (PDT)
In-Reply-To: <4DA3DE55.1080704@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
Cc: Juha Kuikka <juha.kuikka@gmail.com>

Archit Taneja wrote:
> On Tuesday 12 April 2011 01:00 AM, Juha Kuikka wrote:
>>  Hello,
>>
>>  I am wondering if anyone has implemented DSI video mode support in the
>>  DSS driver? I tried to trawl the web and the mailing list archives but
>>  no patches come up.
>>
>>  I am using DM3730.
>
> Video mode isn't supported yet. But there are lots of custom
> implementations of it over the current DSS2. One I can think of is
> motorola's droid 2 and droid X source code:
>
> https://opensource.motorola.com/sf/sfmain/do/viewProject/projects.milestone

Another one is in Archos Gen8 source code:

http://www.archos.com/support/download/software/sources/gen8-gpl-froyo.tgz

