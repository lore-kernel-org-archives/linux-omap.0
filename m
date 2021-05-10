Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B5AC433ED
	for <linux-omap@archiver.kernel.org>; Mon, 10 May 2021 11:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13EE961108
	for <linux-omap@archiver.kernel.org>; Mon, 10 May 2021 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236087AbhEJLda (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 10 May 2021 07:33:30 -0400
Received: from mail.kernelconcepts.de ([188.40.83.200]:38246 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237329AbhEJLOk (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2021 07:14:40 -0400
Received: from [93.132.150.56] (helo=[192.168.1.98])
        by mail.kernelconcepts.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <florian.boor@kernelconcepts.de>)
        id 1lg3qu-0006oM-Sw; Mon, 10 May 2021 13:13:33 +0200
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-omap@vger.kernel.org
References: <38229f0a-85e8-680f-f561-5fc59ac84c6b@kernelconcepts.de>
 <YJTUWaPWSmvwaZMb@atomide.com>
From:   Florian Boor <florian.boor@kernelconcepts.de>
Subject: Re: OMAP4460 cpufreq crashes
Message-ID: <22081c83-0f7f-cef2-6075-79346abf6e9e@kernelconcepts.de>
Date:   Mon, 10 May 2021 13:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YJTUWaPWSmvwaZMb@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hi,

Am 07.05.21 um 07:47 schrieb Tony Lindgren:
> Hmm OK, sounds like the voltages might be wrong.

sounds like my guess wasn't that wrong.

> I don't have one of these boards, but would be glad to add one to my rack
> though if it can boot with NFSroot. If somebody happens to have a spare
> evaluation kit around in the corner to send me, please let me know :)

I have only one currently but I'll keep it in mind any my eyes open.

> The experimental patch below makes the warnings go away, but I'm not sure if
> it's the right fix. Maybe give it a try and see if at least the warnings go away?

The range warnings go away on the 4460 as well. The warning 'twl: not
initialized' of course is still there. Still need add the patch for it again and
test.

Another effect I have noticed is that the system seems to be a little bit more
'stable' now. Which means it does get a little bit further before crashing. I
even managed to get to the login prompt one time...

>> There is a little patch around that changes the initialisation order which makes
>> this messages go away but does not fix the odd behaviour. So maybe this is just
>> a cosmetic issue and the actual problem is somewhere else.
> 
> Sorry I recall some discussion on the twl init problems, but don't remember the
> details. Do you have some link for the patch and discussion?

Here it is:
https://marc.info/?l=linux-omap&m=156462292406719&w=2

Greetings

Florian

-- 
The dream of yesterday                  Florian Boor
is the hope of today                    Tel: +49(0) 271-338857-15
and the reality of tomorrow.		Fax: +49(0) 271-338857-29
[Robert Hutchings Goddard, 1904]        florian.boor@kernelconcepts.de
                                        http://www.kernelconcepts.de/en

kernel concepts GmbH
Hauptstraße 16
57074 Siegen
Deutschland
Geschäftsführer: Ole Reinhardt
HR Siegen, HR B 9613
