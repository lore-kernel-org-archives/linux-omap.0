Return-Path: <SRS0=74QS=AW=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3773BC433DF
	for <linux-omap@archiver.kernel.org>; Sat, 11 Jul 2020 19:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC192078B
	for <linux-omap@archiver.kernel.org>; Sat, 11 Jul 2020 19:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGKTox (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 11 Jul 2020 15:44:53 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:37202 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgGKTox (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 11 Jul 2020 15:44:53 -0400
Received: from belgarion ([86.210.166.159])
        by mwinf5d59 with ME
        id 1vkp230093SgWc603vkqzc; Sat, 11 Jul 2020 21:44:51 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sat, 11 Jul 2020 21:44:51 +0200
X-ME-IP: 86.210.166.159
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 5/7] mach-pxa: palmz72/pcm990: remove soc_camera dependencies
References: <20200626115321.1898798-1-hverkuil-cisco@xs4all.nl>
        <20200626115321.1898798-6-hverkuil-cisco@xs4all.nl>
        <CAK8P3a048hsYw3iQ3+kiPQx9QqHDYJeh8hRuGgxN8NJSpKsOmg@mail.gmail.com>
X-URL:  http://belgarath.falguerolles.org/
Date:   Sat, 11 Jul 2020 21:44:49 +0200
In-Reply-To: <CAK8P3a048hsYw3iQ3+kiPQx9QqHDYJeh8hRuGgxN8NJSpKsOmg@mail.gmail.com>
        (Arnd Bergmann's message of "Fri, 26 Jun 2020 14:58:00 +0200")
Message-ID: <87wo39x2dq.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Jun 26, 2020 at 1:53 PM Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>>
>> The soc_camera driver is about to be removed, so drop camera
>> support from this board. Note that the soc_camera driver itself has
>> long since been deprecated and can't be compiled anymore (it depends
>> on BROKEN), so camera support on this board has been broken for a long
>> time (at least since 4.9 when the pxa_camera.c was removed from soc_camera).
>>
>> Note that there is a new pxa_camera.c driver that replaced the old
>> soc_camera based driver, but using that would require these boards to
>> be converted to use the device tree.
This statement is not accurate, pxa_camera should be working in platform_data
based boards, it's just that the solution to make it work was not found yet if I
remember correctly, since the evolutions to the clocking in v4l2 hit it.

> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Please merge this through the media tree if there are no objections.
So be it.

--
Robert
