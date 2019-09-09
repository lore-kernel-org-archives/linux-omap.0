From: Jean-Jacques Hiblot <jjhiblot@ti.com>
Subject: Re: Status of led-backlight driver
Date: Mon, 9 Sep 2019 13:46:39 +0200
Message-ID: <e40fcd10-85ef-9e04-0960-210736075f1f@ti.com>
References: <20190907100726.GA12763@amd>
 <20190909111410.dwqvg6b4lgxymn2o@holly.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190909111410.dwqvg6b4lgxymn2o@holly.lan>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>, Pavel Machek <pavel@ucw.cz>
Cc: mpartap@gmx.net, tony@atomide.com, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, nekit1000@gmail.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Daniel,

On 09/09/2019 13:14, Daniel Thompson wrote:
> On Sat, Sep 07, 2019 at 12:07:27PM +0200, Pavel Machek wrote:
>> Hi!
>>
>> I don't see the LED-backlight driver in -next. Could it be pushed? It
>> is one of last pieces to get working backlight on Motorola Droid 4...
> Sorry, I dropped the ball on this and was therefore rather late
> reviewing this patchset.
>
> Assuming I have read the code correctly I think there are some
> problems with the max_brightness handling in the backlight code.

Can you comment this? I'll be happy to fix the problem.

Reading the v4 again, I noticed that that I still had not removed the 
brightness scaling. Is that the problem ?

JJ

>
> Daniel.
>
>
