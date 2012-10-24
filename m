From: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 0/4] ARM: dts: Update OMAP5 with address space and
 interrupts
Date: Wed, 24 Oct 2012 11:15:02 +0200
Message-ID: <5087B196.7090804@ti.com>
References: <1351062434-22514-1-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1351062434-22514-1-git-send-email-s-guiriec-l0cyMroinI0@public.gmane.org>
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
To: Sebastien Guiriec <s-guiriec-l0cyMroinI0@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Seb,

Sorry, I missed your previous email, your v2 was the right one.
We do have a single INTC in every OMAP, there is no point to repeat the
same data hundred times.
The DTS are already big enough.

On 10/24/2012 09:07 AM, Sebastien Guiriec wrote:
> Since kernel 3.7 the DTS data are not overwriten by hwmod data we can add the address space
> and interrupt line description inside dtsi file for OMAP5. This serie is updating the
> current OMAP5 IP with missing entry.
> 
> It has been tested on OMAP5 with 3.7-audio-display feature tree.
> - MMC is probing and functional
> - TWL6041 probing (GPIO/I2C)
> - booting (UART)
> 
> Update since v1:
> - Add Ack and review
> - Fix up commit messages.
> 
> Update since v2:
> - Add interrupt-parent.

I will take the previous one to avoid the duplication of attributes.

On top of that I will remove the ones introduce in audio IPs for
consistency on OMAP3/4/5 platforms.

Regards,
Benoit
