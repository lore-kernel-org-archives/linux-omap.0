From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 3/9] ARM: at91: add at91sam9g20ek boards dt support
Date: Thu, 12 Apr 2012 14:47:36 +0200
Message-ID: <20120412124736.GN16641@game.jcrosoft.org>
References: <20120411153515.GK16641@game.jcrosoft.org>
 <1334160079-30831-3-git-send-email-plagnioj@jcrosoft.com>
 <C8443D0743D26F4388EA172BF4E2A7A9317C7B88@DBDE01.ent.ti.com>
 <20120412114559.GM16641@game.jcrosoft.org>
 <C8443D0743D26F4388EA172BF4E2A7A9317C7D68@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A9317C7D68-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Mohammed, Afzal" <afzal-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org" <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 12:14 Thu 12 Apr     , Mohammed, Afzal wrote:
> Hi Jean,
> 
> On Thu, Apr 12, 2012 at 17:15:59, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > If ATMEL is also going driver way, then probably our voice together may be
> > > heard and hopefully it will expedite the matter.
> > I'm going to add it too  my idea was to create something similiar as the
> > pintrl
> > you register the ddifferent bank supported buy the SoC and then the driver
> > request the bank for the dev_name
> > 
> > at soc level you will set the default timings and then the drvier may
> > manipulate them
> > 
> > I already update the API of sam9_smc to abstract the access to the register.
> 
> Is SMC code being converted to driver ?
no I'm busy on pinctrl I just cereate an abstracted API

Best Regards,
J.
