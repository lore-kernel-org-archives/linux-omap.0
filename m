From: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
Date: Wed, 8 Mar 2017 11:14:19 -0800
Message-ID: <20170308191419.GA12085@infradead.org>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com>
 <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com>
 <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com>
 <58C00798.1030302@ti.com>
 <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <650c53fc-482c-feab-faa3-c30689d3d128-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 08, 2017 at 03:32:03PM +0000, Joao Pinto wrote:
> #define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
> 					((0x3 << 20) | (region << 9) |	\
> 					(0x1 << 8)

Can you turn this and any similar macro into inline functions?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
