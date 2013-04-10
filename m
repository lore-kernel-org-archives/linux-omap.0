From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/5] gpio/omap: force restore if context loss is not
 detectable
Date: Wed, 10 Apr 2013 14:41:58 -0500
Message-ID: <5165C086.5010105@ti.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-5-git-send-email-jon-hunter@ti.com>
 <CACRpkdbeABuFXr0Gt6gRto3Pmo0m88AFn_xKJq14VonGg7Doww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CACRpkdbeABuFXr0Gt6gRto3Pmo0m88AFn_xKJq14VonGg7Doww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 04/10/2013 02:39 PM, Linus Walleij wrote:
> On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org> wrote:
> 
>> When booting with device-tree the function pointer for detecting context
>> loss is not populated. Ideally, the pm_runtime framework should be
>> enhanced to allow a means for reporting context/state loss and we could
>> avoid populating such function pointers altogether. In the interim until
>> a generic non-device specific solution is in place, force a restore of
>> the gpio bank when enabling the gpio controller.
>>
>> Adds a new device-tree property for the OMAP GPIO controller to indicate
>> if the GPIO controller is located in a power-domain that never loses
>> power and hence will always maintain its logic state.
>>
>> Signed-off-by: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
> 
> In this case it'd be really helpful to get an ACK from somebody else.
> I have no clue whether this thing is doing what it should, and if
> you were the maintainer I'd apply it but now I'd like to hear from
> Kevin or Santosh first...

Santosh gave the his ACK for 1-4 (see 0/5) and Kevin added his
reviewed-by for 1-4 (again see 0/5).

Cheers
Jon
