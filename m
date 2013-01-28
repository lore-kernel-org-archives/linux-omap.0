From: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Subject: RE: RE: RE: [PATCH v4 12/12] video: da8xx-fb: CCF clock divider
 handling
Date: Mon, 28 Jan 2013 09:17:19 +0000
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EA943E9@DBDE01.ent.ti.com>
References: <cover.1358937685.git.afzal@ti.com>
 <fa8dab522507e087d5a94bac13dda71544911707.1358937685.git.afzal@ti.com>
 <20130123202204.9205.66575@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA92ADF@DBDE01.ent.ti.com>
 <20130124170044.10623.45314@quantum>
 <C8443D0743D26F4388EA172BF4E2A7A93EA9383E@DBDE01.ent.ti.com>
 <20130125224453.10623.74434@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20130125224453.10623.74434@quantum>
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
To: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat-Mmb7MZpHnFY@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "Valkeinen,
 Tomi" <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Mike,

On Sat, Jan 26, 2013 at 04:14:53, Mike Turquette wrote:

> I think Paul W. or someone on the TI side should weigh in on your clkdev
> entries.  My main point is that the actual tree should be modeled and
> clocks shouldn't be globbed together unnecessarily.  As mentioned in the
> other mail thread you might be better off making a divider for your LCDC
> IP block and modeling each node individually.

It seems complexity of driver would increase by creating a new inherited
divider clock and having a total 3-4 clock nodes. The advantage going
with it would be higher configurable resolution for pixel clock.
Current use cases work without higher pixel clock resolution.

And drm driver posted for the same IP is without CCF modeling.

So I will presently not model clock nodes in LCDC IP, later if use cases
badly require, this can be done (and if it happens, hopefully by that
DaVinci would be CCF'ed and it would be more clean to implement it).

Thanks for sharing your ideas.

Regards
Afzal
