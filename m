From: Tony Lindgren <tony@atomide.com>
Subject: Re: Charge counter on droid 4
Date: Mon, 18 Jun 2018 01:28:58 -0700
Message-ID: <20180618082858.GO112168@atomide.com>
References: <20180615080014.GA29192@amd> <20180615083156.GA32102@amd>
 <20180618065827.GN112168@atomide.com> <20180618074023.GA16955@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180618074023.GA16955@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: mpartap@gmx.net, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, nekit1000@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Pavel Machek <pavel@ucw.cz> [180618 07:43]:
> 
> So... there are mA, mAh values. Those come from hardware, and I
> believe we should keep them.
> 
> But there are also mW, mWh values, which are synthetic. Userland can
> compute them from mV, mA values... and it is confusing that kernel
> provides them. (My tendency was to start computing these synthetic
> values in userland, to compare them with "real hardware" values from
> kernel. But then I looked at kernel implementation, and realized they
> are synthetic, tooo...)

Hmm mWh value is based on the hardware sampled shunt
values and number of samples gathered between the
two readings. I'd rather call the calculated values
based on userland reading mV and mA values "synthetic" :)

Regards,

Tony
