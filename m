From: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] ARM: AM33XX: clock: Add dcan clock aliases for device-tree
Date: Mon, 27 Aug 2012 18:02:35 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EA99396@DBDE01.ent.ti.com>
References: <1346061842-28714-1-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1208271717420.26953@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1208271717420.26953-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
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
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 27, 2012 at 22:50:12, Paul Walmsley wrote:
> Hi
> 
> On Mon, 27 Aug 2012, Vaibhav Hiremath wrote:
> 
> > Currently, the device names for the dcan module follows the
> > format "dcan.X", where 'X' is the dcan instance number.
> > On other side, driver may request for clock with/without con_id
> > and dev_id, and it is expected that platform should respect this
> > request and return the requested clock handle.
> > 
> > Now, when using device tree, the format of the device name created
> > by OF layer is different, "<reg-address>.<device-name>",
> > assuming that the device-tree "reg" property is specified.
> > This causes the look-up failure for clock node in dcan driver
> > 
> > To fix this add new dcan clock alias for using device-tree.
> 
> Is the dcan driver present in v3.6-rc kernels?  

Multiple versions have been submitted already, I have validated using them.
Irrespective of this, it is independent change and required for the driver.

Thanks,
Vaibhav
