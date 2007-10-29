From: "arun c" <arun.edarath@gmail.com>
Subject: Re: touch screen on 2430sdp not giving X and Y values
Date: Mon, 29 Oct 2007 18:19:57 +0530
Message-ID: <c656a4d20710290549j2662a6f3r45313cc7be02eac4@mail.gmail.com>
References: <c656a4d20710282330x74dc71e0x68ca6c5309c3b643@mail.gmail.com>
	<001701c819fc$7d6dcce0$6a8918ac@ent.ti.com>
	<c656a4d20710290335h5f754ee2nf4eea969366530d1@mail.gmail.com>
	<20071029122306.C2A7C23B30D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<c656a4d20710290546i2cb75638u98a3b172ec56ee0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <c656a4d20710290546i2cb75638u98a3b172ec56ee0e@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On 10/29/07, David Brownell <david-b@pacbell.net> wrote:
> You should be using the ads7846 driver, not tsc2046 ... the latter
> isn't even in the tree any more, is it?
>
>
I am not using the kernel from git. I am using linux-2.6.14-omap2-v4
kernel.  My sdp is having TSC2046 as touch screen controller ,then
why i should use ads7846 driver??

Regards
Arun
