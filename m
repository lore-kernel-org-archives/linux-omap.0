Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A35EB64DB
	for <linux-omap@archiver.kernel.org>; Mon, 19 Jun 2023 08:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjFSIbf (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 19 Jun 2023 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFSIbe (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jun 2023 04:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B36100;
        Mon, 19 Jun 2023 01:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BCA160B6A;
        Mon, 19 Jun 2023 08:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B53C433C0;
        Mon, 19 Jun 2023 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687163490;
        bh=TSClhyLxMq70prBNpTrAH2YWH7SlNfqgmwDHchD6LfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PY4fO0jI1EenTiaTEn7YbZkXv+X4uOusGhGJSQ5cpbMuzjsq0PtUfJY80qRjxYYP/
         /+4xXEQqyNf8H6T5PG9x2tzr4utR6AhcALc+EMikMR07zuKTQC1UlBNaPqQ8AVJ9/a
         lNaxRd/uB+U6TjPHnmEYp3t0Zk2vmXtqQRFw7bulTxYhq8oa6/hAhJnWQILdWV6Cd8
         Dv8VbjXZ1vim6y5Hwjoqog+/cdfCUG76hwFzqo8CXqnbokFYCaJ91vzOTvyqbtR+1I
         PSmLAzIwJ31DZom3VRvY3Mzis1o2rNS2REyLDDlmrdJBeuaQBX4pIsIgid9xr+Ilrz
         tr72a36h2M3xQ==
Date:   Mon, 19 Jun 2023 09:31:24 +0100
From:   Lee Jones <lee@kernel.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel.thompson@linaro.org,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, geert+renesas@glider.be,
        linux-sh@vger.kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        linux-staging@lists.linux.dev, javierm@redhat.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        michael.j.ruhl@intel.com, stable@vger.kernel.org,
        linux-omap@vger.kernel.org, sam@ravnborg.org,
        dan.carpenter@linaro.org
Subject: Re: [PATCH v3 01/38] backlight/bd6107: Compare against struct
 fb_info.device
Message-ID: <20230619083124.GO3635807@google.com>
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-2-tzimmermann@suse.de>
 <20230614135157.GU3635807@google.com>
 <5720dbc1-a3e4-2b23-28cd-f889d3a5a4fc@suse.de>
 <9f74b8de-9a1b-2547-5eab-d4b4349a6a81@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f74b8de-9a1b-2547-5eab-d4b4349a6a81@suse.de>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, 16 Jun 2023, Thomas Zimmermann wrote:

> Hi Lee
> 
> Am 14.06.23 um 16:13 schrieb Thomas Zimmermann:
> [...]
> > > Can the Backlight patches be applied without the others and visa versa?
> > 
> > Unfortunately not. The rest of the series requires the backlight patches.
> 
> Are you OK with the patches going through drm?

Shouldn't be an issue.

Please ensure my Ack is added to each patch, even if you have to RESEND.

-- 
Lee Jones [李琼斯]
