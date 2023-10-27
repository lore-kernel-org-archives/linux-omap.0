Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883DDC25B6E
	for <linux-omap@archiver.kernel.org>; Fri, 27 Oct 2023 02:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234816AbjJ0CNS (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Thu, 26 Oct 2023 22:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0CNQ (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Thu, 26 Oct 2023 22:13:16 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416E1187;
        Thu, 26 Oct 2023 19:13:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d9443c01a7336-1cc13149621so2470685ad.1;
        Thu, 26 Oct 2023 19:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698372793; x=1698977593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FopIBhfdfdZwsTVrq6qBc/wjjAlq4iSmrR8X3QAmzbg=;
        b=FvHWkrFMOoqoMOaO9IpabdgNGXPmbDAn6IqoRczy+rryPxonQarBRs/CE4pkjyCsAp
         opfT9QzuHKb6viov2lkJeQ2W72Myf/RVLKML/bARTF4h1Cf1Kqf7hBuoBI9PD1xJuh1l
         FlmhddguKup/cJzJDiAtPF/DSVZp26M6rtAQvn93u12mHpUMubnoH+kcB3ycw0pXjIN9
         ppBCZviKYLFw/4yPRWJaWLjTvIvnVQSXMnuy5G9cx8iBcxiftGBiNvtRMXrfXak4I6zv
         voLrUS68VxnJYOMCN5jv2eZlQ02eZE4LjIwqbUgwTKzCcETB7fHzSljlgIZv2KZurARy
         iSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698372793; x=1698977593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FopIBhfdfdZwsTVrq6qBc/wjjAlq4iSmrR8X3QAmzbg=;
        b=ivwGc7oKtl/TeLB/AWGn2BTwhsREbUMu+4yquZ4IZ4oy8RAdWvaujrys5iu4g74M4Q
         e+sg3xKiQiU9WxC1SwZa35I4+eNsWV6M9YRafHu8usciEwM9GU7biGvTxOKydBSRw4Vl
         kaNDBS4aIL4UAaiwGi8Nx9acX4Q9Ho3HYbYggDpjBHdlm7S0T9bpaLYFI9ZP5QnRXlZq
         OSAIVZmI2koblvClnBIvIdyovYTsEEpuPILq6xlcLsRo/P2RDiMcyC6u4nnOFDNuDfmD
         2pbrJaGnNdt7etKXJxmT7Bsrce/wOBKV25eZuzVVHMffMdDGM6sh0JP1V67bDzSBJ9Po
         SvCg==
X-Gm-Message-State: AOJu0YybpkjgX7q2UzLrrG+Cr6AhbIJuihQ4UWJkgF0Q4672Z0IrFa38
        3tdw18bFjc5iyFG8ZcdlKA0=
X-Google-Smtp-Source: AGHT+IHLaxezQwwPE2XDm+4UZzmJa6173YF8HypX6qlE2SrqJql1FS39KbciN067sw6e8sdcN+wtwQ==
X-Received: by 2002:a17:902:e0c3:b0:1ca:273d:232 with SMTP id e3-20020a170902e0c300b001ca273d0232mr1345117pla.0.1698372792633;
        Thu, 26 Oct 2023 19:13:12 -0700 (PDT)
Received: from [127.0.0.1] (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c24c00b001c5fa48b9a0sm356908plg.33.2023.10.26.19.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 19:13:12 -0700 (PDT)
Message-ID: <f70db631-65ca-4c3b-bafa-579ffd64d851@gmail.com>
Date:   Fri, 27 Oct 2023 10:13:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: fix possible memory leak in _ti_omap4_clkctrl_setup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kristo@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tony@atomide.com, claudiu.beznea@microchip.com, robh@kernel.org,
        dario.binacchi@amarulasolutions.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025090741.32997-1-hbh25y@gmail.com>
 <ZTpY+0PAApDo/2Om@smile.fi.intel.com>
Content-Language: en-US
From:   Hangyu Hua <hbh25y@gmail.com>
In-Reply-To: <ZTpY+0PAApDo/2Om@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On 26/10/2023 20:18, Andy Shevchenko wrote:
> On Wed, Oct 25, 2023 at 05:07:41PM +0800, Hangyu Hua wrote:
>> kstrndup and kstrdup_and_replace in clkctrl_get_name can perform
> 
> kstrndup()
> kstrdup_and_replace()
> clkctrl_get_name()
> 

I see. I will send a v2 later.

Thanks,
Hangyu

>> dynamic memory allocation. So clkctrl_name needs to be freed when
>> provider->clkdm_name is NULL.
> 
