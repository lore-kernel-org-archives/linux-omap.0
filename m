Return-Path: <linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SPACE_RATIO autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEFEC388F7
	for <linux-omap@archiver.kernel.org>; Tue, 10 Nov 2020 11:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2455D2076E
	for <linux-omap@archiver.kernel.org>; Tue, 10 Nov 2020 11:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJM5wgaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgKJLOm (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJLOm (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 10 Nov 2020 06:14:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D03C0613CF
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2020 03:14:40 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id p1so12212885wrf.12
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2020 03:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aWHxUGhey1sdeZpkX3+AVgMK2Ne/YLbuPchhZeuH/Uc=;
        b=fJM5wgaDjVrR7PxPlVnAQztZB1IVl9oBIwtvGmcw3IAXMQE3YOUgs5o4O17HieztUA
         qfTNm7C2FQjLHf4bglBB/WHT618E4b4F034ElU4ZD0+0A0odZDmWjgSX1rsN5KRsLMO4
         DeykB940RWboozvg337Y/BhLyZluVx4nNjBoeUjvBjevkM+qmpkVrybQXxAYEIETwBE9
         lCYOugcHON8xTeYXK3wYvTHCeKgSupLh6/TiTTlZB2m3SfZTySHcN1mXxlW6YyRaKhfp
         zeFcTTIGVyFApKnwRObyEs6JgbnOlOzgFeaHhp2fTX/BuXsz0RBpOvntK63Ak1h2AAJj
         yz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aWHxUGhey1sdeZpkX3+AVgMK2Ne/YLbuPchhZeuH/Uc=;
        b=n0KUArMygW1GhIbhnhmwS5Y8gAPCyI04spL/2nlsc/B+xjhIlv1jAQ9xSM0LpgZsyw
         kKTHumwDIwVA+70Mu/JhZNaF4z4L77hrtGLTa1tqvx4Cgw0206xbS2W83ZXnD1LU9TRw
         /EPKF4C8AiIodgT3XWK7gNv76SDCfoIi3VcnHzFido+hOen2asOvRyButk5aMahPxfeI
         be6JPUu+02GKYJMTktCxsoXw4oLXQbdoeIThYbx/6cev+6qmP5OfTYw9DYoUn7XHxSwJ
         cA7A2ep9i9hj/MxeOk5+5LaCIFnm4ZHhKReFFjPmE/GHjHV0F5mwSzmqSX5i1+raj/te
         uwfA==
X-Gm-Message-State: AOAM531gWL0DOaay6b3fn4HDsN7asc0fTcfkUs+TBBtirbv5Jd0Mm1II
        hvinz12qTegekqjNK7SIGAAsdkR5Uc5eofQr9+cZiHzrqQ==
X-Google-Smtp-Source: ABdhPJwWtv4auqTmoAea0qYBb3hHktVqkzr94zqBc5Asks6CLIraXEZdnqZ+famSmvo+5blxMZkS7QiXwrGMYHQb/9A=
X-Received: by 2002:adf:f24a:: with SMTP id b10mr7281813wrp.352.1605006879086;
 Tue, 10 Nov 2020 03:14:39 -0800 (PST)
MIME-Version: 1.0
From:   Raffaele Recalcati <lamiaposta71@gmail.com>
Date:   Tue, 10 Nov 2020 12:14:18 +0100
Message-ID: <CAFU7RzNfOm+FYEAuM17bcgwwZFM3hDkBB-iQ+zNvxT0Z7vK_SA@mail.gmail.com>
Subject: 
To:     linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

unsubscribe linux-omap
