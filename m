From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v7 00/11] usb: musb: adding multi instance support
Date: Fri, 3 Aug 2012 15:48:39 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA7FB18@DBDE01.ent.ti.com>
References: <1343909574-15633-1-git-send-email-ravibabu@ti.com>
 <501AFA6B.4010005@gmail.com>
 <6C6B28D4DC342643927BEAFCE8707BF63E9DB6AE@DBDE01.ent.ti.com>
 <501B8997.2070307@gmail.com>
 <F20D4CDD972CFA4D89D3A083D2D561967FF1F67DE3@BGMAIL01.nvidia.com>
 <501B93AB.7050501@gmail.com>
 <79CD15C6BA57404B839C016229A409A83EA7F4A3@DBDE01.ent.ti.com>
 <501BB8F2.8030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <501BB8F2.8030909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <ajayguptaj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ajay Gupta <ajayg-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Balbi,
 Felipe" <balbi-l0cyMroinI0@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "B,
 Ravi" <ravibabu-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 03, 2012 at 17:11:38, Daniel Mack wrote:
> On 03.08.2012 11:07, Hiremath, Vaibhav wrote:
> > I have just pushed the code (V7 which Ravi submitted), so can you please try 
> > with below branch? 
> > 
> > https://github.com/hvaibhav/am335x-linux/tree/am335x-upstream-staging-usb
> 
> Thanks for doing this, but I'm unfortunately getting tons of merge
> conflicts when I try to put this on top of 3.6-rc1. Still pondering
> which way around is the easiest to get this solved.
> 
> OTOH, I wonder whether your staging branches would need to rebased
> sooner or later anyway?
> 

I have already pushed branch based on v3.6-rc1 (boot tested),

https://github.com/hvaibhav/am335x-linux/tree/am335x-linux-next-master

Thanks,
Vaibhav
