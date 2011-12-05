From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH v5 1/4] regulator: helper routine to extract
 regulator_init_data
Date: Mon, 5 Dec 2011 10:57:33 +0000
Message-ID: <20111205105733.GE11150@opensource.wolfsonmicro.com>
References: <1321615040-13257-1-git-send-email-rnayak@ti.com>
 <1321615040-13257-2-git-send-email-rnayak@ti.com>
 <CAJuYYwRO+AS=WmQfNAe8L6Gi5Dm4VsCuVqk3X5Nb8uUYAdLnJQ@mail.gmail.com>
 <20111204155433.GA16287@opensource.wolfsonmicro.com>
 <CAJuYYwQ-9wCu-+q0S2YYeFYemq74ULdZ-EwPGLWKHA4+0VZcsA@mail.gmail.com>
 <20111205103447.GC11150@opensource.wolfsonmicro.com>
 <CAJuYYwSRW-=XufvHS1miO2xNANwQMZqPbt=VyPEonywnAsvVUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwSRW-=XufvHS1miO2xNANwQMZqPbt=VyPEonywnAsvVUQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 05, 2011 at 04:14:40PM +0530, Thomas Abraham wrote:
> On 5 December 2011 16:04, Mark Brown

> > With the regulator device tree bindings if the regulator is configured
> > to run a single voltage the bindings will set apply_uV unconditionally
> > so there's no need for a separate constraint.

> Sorry if I have missed this, but I could not find 'apply_uV' being set
> as you described in the v5 of the regulator-dt patchset.

Yes, looks like Rajendra missed that - just fixed it.
