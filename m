From: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] dt: export of_have_populated_dt
Date: Tue, 10 Apr 2012 12:21:50 -0400
Message-ID: <87y5q3v9pd.fsf@laptop.org>
References: <1334070672-11252-1-git-send-email-balajitk@ti.com>
 <4F845D99.7020705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <4F845D99.7020705-l0cyMroinI0@public.gmane.org> (Benoit Cousson's message of "Tue, 10
 Apr 2012 18:19:37 +0200")
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, Apr 10 2012, Cousson, Benoit wrote:
> Hi Balaji,
>
> On 4/10/2012 5:11 PM, Balaji T K wrote:
>> If of_have_populated_dt is called from module, build fails with "allnodes"
>> undefined error, so remove inline and export of_have_populated_dt.
>
> Is this function really called from the MMC driver?

~/git/linux % git grep of_have_populated_dt drivers/
drivers/gpio/gpio-samsung.c:    if (!of_have_populated_dt())
drivers/mmc/host/omap_hsmmc.c:  if (of_have_populated_dt() && !vdd)
drivers/mmc/host/omap_hsmmc.c:                   (!of_have_populated_dt())) {

- Chris.
-- 
Chris Ball   <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>   <http://printf.net/>
One Laptop Per Child
