From: Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 08/22] PCI: dwc: designware: Add EP mode support
Date: Thu, 9 Mar 2017 11:55:01 +0000
Message-ID: <af4dd1db-dc24-1797-a43a-8487a95e47f9@synopsys.com>
References: <1487325042-28227-1-git-send-email-kishon@ti.com>
 <1487325042-28227-9-git-send-email-kishon@ti.com>
 <45e5288e-d11f-c855-af9b-692a42d878c6@synopsys.com> <58BE42B2.20305@ti.com>
 <02461be2-268d-485a-2bc4-3b148726d37d@synopsys.com>
 <aa9835a7-07f4-d042-d04a-b0d9cc0ea3de@synopsys.com> <58BFEC7D.3090608@ti.com>
 <35d539ba-956f-330e-c28d-b67c3d414578@synopsys.com> <58C00798.1030302@ti.com>
 <650c53fc-482c-feab-faa3-c30689d3d128@synopsys.com>
 <20170308191419.GA12085@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170308191419.GA12085-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joao Pinto <Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jingoo Han <jingoohan1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Christoph,

Às 7:14 PM de 3/8/2017, Christoph Hellwig escreveu:
> On Wed, Mar 08, 2017 at 03:32:03PM +0000, Joao Pinto wrote:
>> #define PCIE_GET_ATU_INB_UNR_REG_ADDR(region, register)		\
>> 					((0x3 << 20) | (region << 9) |	\
>> 					(0x1 << 8)
> 
> Can you turn this and any similar macro into inline functions?
> 

Use an inline functions instead of macro is fine by me. In the initial patch I
implemented as a macro since it only does simple bit shifts and nothing else and
seemed simpler as a macro.

Thanks,
Joao
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
