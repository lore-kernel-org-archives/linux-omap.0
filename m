From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv6 RESEND 01/14] dt-bindings: remoteproc: Add OMAP
 remoteproc bindings
Date: Tue, 11 Feb 2020 20:06:53 -0600
Message-ID: <20200212020653.GA27019@bogus>
References: <20200211152125.23819-2-t-kristo@ti.com>
 <20200211153313.24072-1-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41704 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCGz (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Tue, 11 Feb 2020 21:06:55 -0500
Content-Disposition: inline
In-Reply-To: <20200211153313.24072-1-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: bjorn.andersson@linaro.org, ohad@wizery.com, linux-remoteproc@vger.kernel.org, afd@ti.com, linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>, devicetree@vger.kernel.org

On Tue, Feb 11, 2020 at 05:33:13PM +0200, Tero Kristo wrote:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the device tree bindings document for the IPU and DSP
> remote processor devices on OMAP4+ SoCs.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Suman Anna <s-anna@ti.com>
> [t-kristo@ti.com: converted to schema]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> Quick resend. Missed adding Rob+DT list in CC, git is too clever to get rid of
> CC fields automatically...
> 
> v6: made memory-regions property optional

Small enough change to keep my R-by.

Reviewed-by: Rob Herring <robh@kernel.org>

> 
>  .../remoteproc/ti,omap-remoteproc.yaml        | 321 ++++++++++++++++++
>  1 file changed, 321 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,omap-remoteproc.yaml
