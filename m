From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 12/12] USB: ehci-omap: Fix detection in HSIC mode
Date: Wed, 13 Mar 2013 13:48:11 +0200
Message-ID: <5140677B.4030505@ti.com>
References: <Pine.LNX.4.44L0.1303121201050.2153-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1303121201050.2153-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
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
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 03/12/2013 06:07 PM, Alan Stern wrote:
> On Tue, 12 Mar 2013, Roger Quadros wrote:
> 
>> The HSIC devices need to be kept in reset while the EHCI controller
>> is being initialized and only brought out of reset after the
>> initialization is complete, else HSIC devices will not be detected.
> 
> This is not a great description of what the patch does.  You should say
> that it moves PHY initialization until after EHCI initialization is
> complete, instead of initializing the PHYs first, shutting them down
> again, and then initializing them a second time.
> 

Okay will update the description.

>> Also remove outdated TODO list from header.
>>
>> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
>> CC: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
>> ---
>>  drivers/usb/host/ehci-omap.c |   38 +++++++++++++++-----------------------
>>  1 files changed, 15 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
>> index 1ba1df8..dc2de47 100644
>> --- a/drivers/usb/host/ehci-omap.c
>> +++ b/drivers/usb/host/ehci-omap.c
>> @@ -29,12 +29,6 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
>>   *
>> - * TODO (last updated Feb 27, 2010):
>> - *	- add kernel-doc
>> - *	- enable AUTOIDLE
>> - *	- add suspend/resume
>> - *	- add HSIC and TLL support
>> - *	- convert to use hwmod and runtime PM
>>   */
>>  
>>  #include <linux/kernel.h>
>> @@ -90,26 +84,13 @@ static inline u32 ehci_read(void __iomem *base, u32 reg)
>>  static int omap_ehci_init(struct usb_hcd *hcd)
>>  {
>>  	struct ehci_hcd	*ehci = hcd_to_ehci(hcd);
>> -	struct omap_hcd	*omap = (struct omap_hcd *)ehci->priv;
>> -	int rc, i;
>> -
>> -	/* Hold PHYs in reset while initializing EHCI controller */
>> -	for (i = 0; i < omap->nports; i++) {
>> -		if (omap->phy[i])
>> -			usb_phy_shutdown(omap->phy[i]);
>> -	}
>> +	int rc;
>>  
>>  	/* we know this is the memory we want, no need to ioremap again */
>>  	ehci->caps = hcd->regs;
>>  
>>  	rc = ehci_setup(hcd);
>>  
>> -	/* Bring PHYs out of reset */
>> -	for (i = 0; i < omap->nports; i++) {
>> -		if (omap->phy[i])
>> -			usb_phy_init(omap->phy[i]);
>> -	}
>> -
>>  	return rc;
>>  }
> 
> Now that there's almost nothing left of this function, you can get rid
> of it completely.  Move the assignment to ehci->caps into
> ehci_hcd_omap_probe() and remove the init entry in the overrides
> structure.

Right. Sounds good.

cheers,
-roger
