From: Vignesh R <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] Input: rotary-encoder- Add support for absolute
 encoder
Date: Wed, 25 May 2016 14:14:29 +0530
Message-ID: <574565ED.3060205@ti.com>
References: <1463648641-6931-1-git-send-email-vigneshr@ti.com>
 <1463648641-6931-2-git-send-email-vigneshr@ti.com>
 <20160520163404.GC14951@dtor-ws> <5742CB03.8010805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5742CB03.8010805@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Guido Martinez <guido@vanguardiasur.com.ar>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Masanari Iida <standby24x7@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Timo Teras <timo.teras@iki.fi>, Geert Uytterhoeven <geert@linux-m68k.org>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Moritz Fischer <moritz.fischer@ettus.com>linu
List-Id: linux-omap@vger.kernel.org

Hi Dmitry,

On 05/23/2016 02:48 PM, R, Vignesh wrote:
> 
> 
> On 5/20/2016 10:04 PM, Dmitry Torokhov wrote:
>> On Thu, May 19, 2016 at 02:34:00PM +0530, Vignesh R wrote:
>>> There are rotary-encoders where GPIO lines reflect the actual position
>>> of the rotary encoder dial. For example, if dial points to 9, then four
>>> GPIO lines connected to the rotary encoder will read HLLH(1001b = 9).
>>> Add support for such rotary-encoder.
>>> The driver relies on rotary-encoder,absolute-encoder DT property to
>>> detect such encoders.
>>> Since, GPIO IRQs are not necessary to work with
>>> such encoders, optional polling mode support is added using
>>> input_poll_dev skeleton. This is can be used by enabling
>>> CONFIG_INPUT_GPIO_ROTARY_ENCODER_POLL_MODE_SUPPORT.
>>
>> Does this really belong to a rotary encoder and not a new driver that
>> simply translates gpio-encoded value into ABS* event?
>>
> 
> Currently rotary encoder driver only supports incremental/step counting
> rotary devices. However, the device that is there on am335x-ice is an
> absolute encoder but, IMO, nevertheless a kind of rotary encoder. The
> only difference is that there is no need to count steps and the absolute
> position value is always available as binary encoded state of connected
> GPIOs.
> The hardware on am335x-ice is a mechanical rotary encoder switch
> connected over 4 GPIOs. It is same as binary encoder described at [1]
> (except there are 4 GPIO lines), so this lead me to add support in
> rotary-encoder.
> 
> [1]https://en.wikipedia.org/wiki/Rotary_encoder#Standard_binary_encoding
> 

Could you please comment on how would you like to support above
described encoder: As a new driver or with existing driver with new
compatible/mode setting via DT or as suggest by Uwe in another reply?
IMHO, supporting using existing driver with new mode/compatible string
looks a better option as the hardware is a kind of rotary-encoder.

-- 
Regards
Vignesh
