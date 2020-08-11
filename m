Return-Path: <SRS0=0/w7=BV=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AA7C433E0
	for <linux-omap@archiver.kernel.org>; Tue, 11 Aug 2020 12:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8E12075D
	for <linux-omap@archiver.kernel.org>; Tue, 11 Aug 2020 12:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZN04rm+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgHKMSi (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgHKMSa (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Aug 2020 08:18:30 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838D7C061787
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2020 05:18:13 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id z3so10398067ilh.3
        for <linux-omap@vger.kernel.org>; Tue, 11 Aug 2020 05:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=T7CVhgvin3CL+UV/ziIiQf2pi2IRKRySV4X1oWVKSC4=;
        b=ZN04rm+N0vw+tdpR1abL/6MRPSxbvi+dlSpDf3NmWSeYNnWoeEMFaJL3UELNqO+yLP
         KKeg9e5bSjiTy+mEwuw7k3wSTwmXoMiun9IgpTb8J5LJM+X7lsBPjO/dZdyyRo4BZh6u
         /4Lb5dzf9+9n7y20cMxBj+0nwqWzXycNdyIgwAOgs1CW+RPVLgJpuJ+PJDsq7dWQblLl
         m6ZU6PnCdsK1lC3a1ySR5THq7HXvdSAGaqNSOFpQDR5uhkJAE0VoLa2jGZ+IsoUdRPVF
         8242VbTey1i53+TuGc4kSneBNYjrnL/ZB4WrpjS91pOPdqbdo18YZQz8mUD/IkdLCxZ9
         XiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T7CVhgvin3CL+UV/ziIiQf2pi2IRKRySV4X1oWVKSC4=;
        b=UFFwoXTnoO9+sGYef2teNy1WuqOLZut3I8V/PlEbLVlCLgQwGOeGgO87hyj14ny0Dw
         WEnkfC2HgUia77mrDgREIx8mvfCJRZeUjELkbTMApiohj4G4fuzJRp6tjBgjRl/bpxpv
         e4MmLU6b4Bf1xKnS3LAgGjFNMnZSy6tvYYZve9fuXiypg5OArQlvoJ+PNCSpB029ud80
         ZM24H1Fzc1ZuRXBeWQYMDXpQtJI4GiAfrlIQPuR8gJjL4+6P0WSyChdocFy3A+Mn4Y4t
         vFtPtIlDYhVG1lK8m/MW39ANmtZvJOJdsiL3O3S+j3ast+YKOrOTYWQXKJDFBKuMDQTT
         TTAA==
X-Gm-Message-State: AOAM531jaDwtAIAJULTrzM1JQMOA6UdCMUeojTusq6DYi0UpfN00N38q
        R38IoxsBiIXZnDO+wou/ST6SKYxw6vYVuB4oxIkN5A==
X-Google-Smtp-Source: ABdhPJwxpbCtH8vaWt98OmdpDJHTt4CRp96RCoEX3TwWmNMNonh0AIC8fHEJ8v+ZkKem4hzl5yxI+2Xn+8C2l4o6FZ0=
X-Received: by 2002:a92:364f:: with SMTP id d15mr962208ilf.89.1597148291215;
 Tue, 11 Aug 2020 05:18:11 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 11 Aug 2020 07:18:00 -0500
Message-ID: <CAHCN7xLvaSBoN4Qs8zG2koBmZEuNxiZkm4m0etqKu32AsvVJcA@mail.gmail.com>
Subject: Resyncing omap2plus_defconfig
To:     Tony Lindgren <tony@atomide.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Tony,

What is the rule on re-syncing omap2plus_defconfig?  I want to add a
config option, but the act of 'make savedefconfig' changes the order
of a bunch of stuff.  Can I submit a patch to re-sync
omap2plus_defconfig, or is that something you need to do?  If you want
me to do it, please let me know which tree and branch I should use as
the basis.

adam
