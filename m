Return-Path: <SRS0=sQ2K=AK=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B6BC433E4
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AE32067D
	for <linux-omap@archiver.kernel.org>; Mon, 29 Jun 2020 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COU2zmBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgF2TH4 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730829AbgF2THo (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jun 2020 15:07:44 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FBAC02E2EA;
        Mon, 29 Jun 2020 07:19:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y2so17350917ioy.3;
        Mon, 29 Jun 2020 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=47yB/J2jJp/Hyiy9M1uWjEhRFrnBjwMwfE/nDbFPyRk=;
        b=COU2zmBMOm8jAHhSa++Aeij+HAuixWLkN3X9fJ0pp3riGsqzqZL1CRUWjbssHufSb3
         gGm8EG9uruuKCtRAbTeqEFPbpPwFVXlmWaEpomInYFEsUjIMTgs0/WtnBKCqIuTcfRcy
         WzB8luRn2ZuiM0dmbKxEP9KHf+/40+l7aiGoL7EPsd0ni5TOtKvyaUfdpyktQrZeKXuv
         8tQqybvpp+PfzvX0U0eu8bHUltSlu19P4defCduKZUGmn4OUKxeO8/MHvqDDtIrKg5EI
         MqLQ88Ll1cYGe57lf/CAX8xNMpPYzaxwO0MlzNAq6KZpIK/vPAcDtF3bdoAHltthEuXb
         kZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=47yB/J2jJp/Hyiy9M1uWjEhRFrnBjwMwfE/nDbFPyRk=;
        b=f9r3KXQgYsxVaadQsYHxAx208E5S6WClXrMZIEbGlDmb3OTDb3Tm+V5cY2Tx6kfLaj
         uAG9uiXeAVNZXSIINn4BT55s/Mzj3LqaZIARy668hcOd87P2wZWuArluzKwJlTbWPVVx
         Q7Y4JZoRUSgpTOHf8C/rUIkrdxxv4sk9C+ejkhVALDv2T7+TLKD2rbVOlCXGS6x5+W1h
         YCfUKzUqCwygXVSbuGDoIgJ4RMamRWSL0hvBLVejZlzAPE+7dmDN73g+uaR5exDQyT6R
         Nj9V3Tg59i7TuP8swMUf49ZmnYNYaM6EVmOG9QplJW9jsMN6J+KHOmfoYFiZnkpvAtSW
         hAmA==
X-Gm-Message-State: AOAM531MxSgBNy/eWO+cq8LSAuleFJsbvZRqKE5SZqdqDQA2YRkwn1tN
        UZeV0CBouO+OFdXuhrs/VcPAu/RltUZZvN3EpKGkjaGR
X-Google-Smtp-Source: ABdhPJyC8hLzoJwSTAJ37OV6pmSucDMOB0wnAWTtZUr3eTh4i+eQjTnFBjIWQLJ5kNgYMsyBdON3CzqZ8fxg/7DhBJk=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr15996040iod.92.1593440382903;
 Mon, 29 Jun 2020 07:19:42 -0700 (PDT)
MIME-Version: 1.0
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 29 Jun 2020 09:19:32 -0500
Message-ID: <CAHCN7xJWL4_P4Dz04fSVPtSQJNVo-reW0SO7DqkMDhhBEVwsYg@mail.gmail.com>
Subject: ti-soc-thermal fails on OMAP3
To:     Linux-OMAP <linux-omap@vger.kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

I submitted a patch in November to enable idling of the bandgap on
OMAP3, however it was never applied.  I spent some time over the
weekend trying refresh my memory on what was going on and what's left
to do so I could re-submit the patch after re-basing it.
Unfortunately, I am getting some errors even before attempting to
re-apply my patch.

ti-soc-thermal: probe of 48002524.bandgap failed with error -22

I did some digging on this.  EINVAL (-22) is set  in ti-thermal-common
in two places, and in both places it's trying either
ti_bandgap_get_sensor_data or ti_thermal_build_data.

I haven't had time to bisect yet, but I will.  I was just hoping
someone might have some ideas to save me some time.

thanks

adam
