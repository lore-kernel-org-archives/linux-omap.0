From: Krzysztof Opasiak <k.opasiak@samsung.com>
Subject: Re: [PATCH v3 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Date: Mon, 20 Jul 2015 16:43:19 +0200
Message-ID: <55AD0907.8090605@samsung.com>
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1436941953-1327-2-git-send-email-r.baldyga@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org, balbi@ti.com
Cc: devel@driverdev.osuosl.org, linux-usb@vger.kernel.org, m.szyprowski@samsung.com, linux-arm-kernel@lists.infradead.org, johnyoun@synopsys.com, linuxppc-dev@lists.ozlabs.org, cernekee@gmail.com, nicolas.ferre@atmel.com, michal.simek@xilinx.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Peter.Chen@freescale.com, dahlmann.thomas@arcor.de, andrzej.p@samsung.com, leoli@freescale.com, robert.jarzmik@free.fr, daniel@zonque.org, linux-geode@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On 07/15/2015 08:31 AM, Robert Baldyga wrote:
> So far it was necessary for usb functions to set ep->driver_data in
> endpoint obtained from autoconfig to non-null value, to indicate that
> endpoint is claimed by function (in autoconfig it was checked if endpoint
> has set this field to non-null value, and if it has, it was assumed that
> it is claimed). It could cause bugs becouse if some function doesn't

	s/becouse/because

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
