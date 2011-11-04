From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3 0/4] Device tree support for regulators
Date: Fri, 4 Nov 2011 13:21:26 -0700
Message-ID: <CAOesGMii8v3DOCjWpuF3=+EVu+-HYGys=7RRgpk+9U=FxTHwOA@mail.gmail.com>
References: <1319702185-16108-1-git-send-email-rnayak@ti.com>
	<20111027090847.GC6641@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20111027090847.GC6641@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: patches@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 27, 2011 at 2:08 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Oct 27, 2011 at 01:26:21PM +0530, Rajendra Nayak wrote:
>
>> v3 is based on the latest devicetree/next and is tested
>> (with twl adaptaions, which will be posted seperately)
>> on the OMAP4 panda and OMAP4 sdp boards.
>
> Looking at the device bindings I notice that these bindings loose the
> ability to assign a descriptive name to regulator outputs. =A0This is
> really useful for making it easy to tie the code and the schematics
> together - you can make the runing system use the same name as the
> schematic.

That can easily be added by having a output-name property in the
regulator device node.

-Olof
