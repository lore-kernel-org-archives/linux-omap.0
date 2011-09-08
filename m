From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Tasks schedule/migration issue with CPU hotplug?
Date: Thu, 08 Sep 2011 14:55:48 +0200
Message-ID: <1315486548.20256.4.camel@twins>
References: <CAOwKts_WTDBLkz9=0MBhs6wzc67XD_bYgGMiZ-JUM+8O7gP_fw@mail.gmail.com>
	<CAOwKts8pXt6spknNfBV-wy4_KoSp-JaZsdbzOxxWTqu=f6X3Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOwKts8pXt6spknNfBV-wy4_KoSp-JaZsdbzOxxWTqu=f6X3Bg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: TAO HU <tghk48@motorola.com>
Cc: "yong.zhang0" <yong.zhang0@gmail.com>, Ingo Molnar <mingo@elte.hu>, linux-omap <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, 2011-09-08 at 14:47 +0800, TAO HU wrote:
> > We seems got a schedule/migration issue in a OMAP4430 dual-core system.
> > The kernel base is 2.6.35.7 and we're using CFS.

step 1, try with a kernel that isn't quite as fossilized 
	(3.0 or even better 3.1-rc)
step 2, if no luck, report that
step 3, when sending email, 
     3a, don't wrap machine output
     3b, include .config like things
