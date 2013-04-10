From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/5] gpio/omap: force restore if context loss is not
 detectable
Date: Wed, 10 Apr 2013 21:39:40 +0200
Message-ID: <CACRpkdbeABuFXr0Gt6gRto3Pmo0m88AFn_xKJq14VonGg7Doww@mail.gmail.com>
References: <1365106576-31816-1-git-send-email-jon-hunter@ti.com>
 <1365106576-31816-5-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1365106576-31816-5-git-send-email-jon-hunter@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>, device-tree <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Apr 4, 2013 at 10:16 PM, Jon Hunter <jon-hunter@ti.com> wrote:

> When booting with device-tree the function pointer for detecting context
> loss is not populated. Ideally, the pm_runtime framework should be
> enhanced to allow a means for reporting context/state loss and we could
> avoid populating such function pointers altogether. In the interim until
> a generic non-device specific solution is in place, force a restore of
> the gpio bank when enabling the gpio controller.
>
> Adds a new device-tree property for the OMAP GPIO controller to indicate
> if the GPIO controller is located in a power-domain that never loses
> power and hence will always maintain its logic state.
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

In this case it'd be really helpful to get an ACK from somebody else.
I have no clue whether this thing is doing what it should, and if
you were the maintainer I'd apply it but now I'd like to hear from
Kevin or Santosh first...

Yours,
Linus Walleij
