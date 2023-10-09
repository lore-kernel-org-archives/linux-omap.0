Return-Path: <linux-omap-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0769CE95A98
	for <linux-omap@archiver.kernel.org>; Mon,  9 Oct 2023 14:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbjJIOt7 (ORCPT <rfc822;linux-omap@archiver.kernel.org>);
        Mon, 9 Oct 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjJIOt7 (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Mon, 9 Oct 2023 10:49:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8C7B7;
        Mon,  9 Oct 2023 07:49:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DDAC433C7;
        Mon,  9 Oct 2023 14:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696862997;
        bh=0dalE74v4lnBvJvSmP3JrLr6kKKhrnt8ulY17ktBunY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkGL2QNf3tO/XWzRQ2GvFSyjzaIkfLIPk2DhuXpcQ9zcbaDBMqb4f579lSVRwSVh9
         Ll0pN5BNa22w/Nabvbi9iv6T27Ll6UefSZJKdaq2qneI7BvLY4WkmYRB8/tqGxJIx2
         prUmCl18aPQ223X1EfOGyNwcSYqy8MSQSApg3LOGzM4b2cIi0IjaVkIYyHkuFtc0UJ
         eEFrtOFp6aGo3mc+28cyhI4CsE3WNxFlB2U5wPJCSe6mhSLlaoDHFkUC8yxTuL4d8J
         bLnHzdKhMxLngJIBl72IbwCt2ktlXA9Uck1Rd1pJXPMgwqjlW/6vuzVWYxaQyANx8O
         s/TKH4QpRe1/g==
Date:   Mon, 9 Oct 2023 07:53:53 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Tero Kristo <kristo@kernel.org>, patches@opensource.cirrus.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] clk: Use device_get_match_data()
Message-ID: <4dvxssedquxbq4hl6pnkju73n2iilzhaeuak5jgmamms7r33yw@eof45x7mt6co>
References: <20231006213959.334439-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006213959.334439-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-omap.vger.kernel.org>
X-Mailing-List: linux-omap@vger.kernel.org

On Fri, Oct 06, 2023 at 04:39:58PM -0500, Rob Herring wrote:
> Use preferred device_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Nice, thanks for cleaning this up.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
