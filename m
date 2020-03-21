Return-Path: <SRS0=noxr=5G=vger.kernel.org=linux-omap-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05541C43332
	for <linux-omap@archiver.kernel.org>; Sat, 21 Mar 2020 21:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03B42077D
	for <linux-omap@archiver.kernel.org>; Sat, 21 Mar 2020 21:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isL9X3p+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgCUVkR (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:40:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgCUVkQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Sat, 21 Mar 2020 17:40:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id b2so11838839wrj.10;
        Sat, 21 Mar 2020 14:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=CfHlNgOI42CTECem8O1J/UAg3b2kVbBzXQexugyyN68=;
        b=isL9X3p+PtaMil2IBPnN6ki3XitSaHZsjB37Lol9DLBJXkFtVYkE6NZMypFRT0RVcV
         /cbGZV8BRGHIZPTNi6w2iem9g2uaM2QMNNIGeRjuNeUsOWb/sNzXlIBZ5DYSqVi2DO+J
         JRUuPVnxpJdI+mdjEq/WARTjFw0vZCPmqndHWhFjK8XI5lmJ6hGqOxU3u9IJ4+WDuzHf
         8Der/msGM4kDpeRTx6RmRGG0xUuzlJJOPr+HIP7FmnnoBU8qjA22BawGbKeXVx5UZA+G
         /H5MmjTBMiDGJtNO0/clA5Urnxz+Ii8pXunC1vLfB98ADMtFZHOSZDyyPqp1LUJNSw4l
         MnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=CfHlNgOI42CTECem8O1J/UAg3b2kVbBzXQexugyyN68=;
        b=i5ZpsuhPHPoWYbGBcBq4JRbr/a9jSuVMVby4zx8XnMZ/cFGYbl+stwQgk0m1oE6KS3
         lrnP7k/kgcXxiF/r/XN792Nzd3rpnttpIGJgXQgFoAyep4deOkx2PS67+rE6n4WzvE6l
         yuM/Bkhf1GX9Gz4Wjpj5nFfGGzWFJLzHDphJlK/G+6Ya405kjSeO0l07tE7aaYIOe+05
         ZWI7K8W9nm7g11mTRq+gFNS6jA+aDwA3J4eaA4a2zOktr7FK2HjBI3bpK76B49Y+Dxvo
         z68Vz3VeYjzPUd+Cfcc1Z8iPpg1zvuy0xEfnZATxDtKxSlnTsViYNjBZDAFjsD+MkxC6
         6/fA==
X-Gm-Message-State: ANhLgQ2qlS+IEduPjjVGmsF5kbZjkZvoSwPnC4JYXeKw1/gyWbHzKMVL
        pqhBm6z6vUhpec8dDD+hCRCxtoDjK5Zr+g==
X-Google-Smtp-Source: ADFU+vvdXVAtQl/PPBIAfyb1+A2CcnRkdlUxzc4Z506E/anZkOACZe3pT7abISBmykuJGneieRXxvQ==
X-Received: by 2002:adf:a489:: with SMTP id g9mr18514578wrb.44.1584826815119;
        Sat, 21 Mar 2020 14:40:15 -0700 (PDT)
Received: from supervisor.net28 ([46.53.253.27])
        by smtp.gmail.com with ESMTPSA id u16sm15194973wro.23.2020.03.21.14.40.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 21 Mar 2020 14:40:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
To:     "Tony Lindgren" <tony@atomide.com>
Cc:     "Merlijn Wajer" <merlijn@wizzup.org>,
        "Pavel Machek" <pavel@ucw.cz>, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 03/15] power: supply: cpcap-battery: Fix battery low
 status reporting
References: <20200315151206.30909-1-spinal.by@gmail.com>
 <20200315151206.30909-3-spinal.by@gmail.com>
 <20200321144710.GV37466@atomide.com>
Date:   Sun, 22 Mar 2020 00:40:13 +0300
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Arthur D." <spinal.by@gmail.com>
Message-ID: <op.0humhbikhxa7s4@supervisor.net28>
In-Reply-To: <20200321144710.GV37466@atomide.com>
User-Agent: Opera Mail/12.16 (Linux)
Sender: linux-omap-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

Will do. Thanks!

> Please set up bitmask in ddata for unsigned int battery_low:1; instead of
> using a static variable here. If we ever had two instances of cpcap on  
> the same device the static variable here would not work :)
