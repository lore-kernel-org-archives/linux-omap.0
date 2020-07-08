Return-Path: <SRS0=RG6i=AT=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B4C433E0
	for <linux-omap@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9040520775
	for <linux-omap@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgGHKdO (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:33:14 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:27596 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgGHKdN (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jul 2020 06:33:13 -0400
Received: from belgarion ([86.210.166.159])
        by mwinf5d09 with ME
        id 0aZC2300A3SgWc603aZC7L; Wed, 08 Jul 2020 12:33:12 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 08 Jul 2020 12:33:12 +0200
X-ME-IP: 86.210.166.159
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] pxa_camera: update MODULE_DESCRIPTION
References: <20200626115321.1898798-1-hverkuil-cisco@xs4all.nl>
        <20200626115321.1898798-3-hverkuil-cisco@xs4all.nl>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 08 Jul 2020 12:33:12 +0200
In-Reply-To: <20200626115321.1898798-3-hverkuil-cisco@xs4all.nl> (Hans
        Verkuil's message of "Fri, 26 Jun 2020 13:53:16 +0200")
Message-ID: <874kqixpnb.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Hans Verkuil <hverkuil-cisco@xs4all.nl> writes:

> Remove the confusing SoC Camera reference.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
