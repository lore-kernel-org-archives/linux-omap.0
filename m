From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 1/2] gpio/omap: move bank->dbck initialization to omap_gpio_mod_init()
Date: Wed, 11 Jul 2012 23:26:31 +0530
Message-ID: <CAC83ZvK614pB0Jx56OMXfmFf89cTAP+AAf=H-imbH2Y1Qv7DSg@mail.gmail.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
	<1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
	<alpine.DEB.2.00.1207111148400.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1207111148400.25585@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, linus.walleij@stericsson.com, grant.likely@secretlab.ca
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 11, 2012 at 11:21 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 11 Jul 2012, Tarun Kanti DebBarma wrote:
>
>> Since the bank->dbck initialization in a one time operation there
>> is no need to keep this within gpio_debounce(). Therefore, moving
>> clk_get(bank->dbck) to omap_gpio_mod_init(). Since the value of
>> bank->dbck would be NULL at the beginning, this check has been
>> removed.
>>
>> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
>> Reported-by: Paul Walmsley <paul@pwsan.com>
>> Reviewed-by: Jon Hunter <jon-hunter@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Rajendra Nayak <rnayak@ti.com>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> Cc: Cousson, Benoit <b-cousson@ti.com>
>> Cc: Paul Walmsley <paul@pwsan.com>
>> ---
>>  drivers/gpio/gpio-omap.c |   10 ++++------
>>  1 files changed, 4 insertions(+), 6 deletions(-)
>
> Reviewed-by: Paul Walmsley <paul@pwsan.com>
>
> These drivers are maintained by Grant Likely and Linus Walleij:
>
> GPIO SUBSYSTEM
> M:      Grant Likely <grant.likely@secretlab.ca>
> M:      Linus Walleij <linus.walleij@stericsson.com>
> S:      Maintained
> T:      git git://git.secretlab.ca/git/linux-2.6.git
> F:      Documentation/gpio.txt
> F:      drivers/gpio/
> F:      include/linux/gpio*
>
> So you'll want to cc them.  They are probably also who should merge these.
Ok, I wanted Kevin to have a look first. Anyways, I have cc'ed.
Thanks.
--
Tarun
>
>
> - Paul
