From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Git tree broken for fsample
Date: Fri, 24 Aug 2007 10:37:56 +0530
Message-ID: <5d5443650708232207k63bb094fm2b9aae1c4129180e@mail.gmail.com>
References: <46CDAAC5.2050101@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <46CDAAC5.2050101@celunite.com>
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
To: Vivek Kutal <vivek.kutal@celunite.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi Vivek,

On 8/23/07, Vivek Kutal <vivek.kutal@celunite.com> wrote:
> Hi,
>       I get the following errors when I try to compile the kernel for
> fsample.
>
>
> arch/arm/mach-omap1/board-fsample.c:43: error: `KEY_CENTER' undeclared
> here (not in a function)
> arch/arm/mach-omap1/board-fsample.c:43: error: initializer element is
> not constant
> arch/arm/mach-omap1/board-fsample.c:43: error: (near initialization for
> `fsample_keymap[4]')
> arch/arm/mach-omap1/board-fsample.c:44: error: `KEY_0_5' undeclared here
> (not in a function)
> arch/arm/mach-omap1/board-fsample.c:44: error: initializer element is
> not constant
> arch/arm/mach-omap1/board-fsample.c:44: error: (near initialization for
> `fsample_keymap[5]')
> arch/arm/mach-omap1/board-fsample.c:45: error: `KEY_SOFT2' undeclared
> here (not in a function)
> arch/arm/mach-omap1/board-fsample.c:45: error: initializer element is
> not constant
> arch/arm/mach-omap1/board-fsample.c:45: error: (near initialization for
> `fsample_keymap[6]')
> arch/arm/mach-omap1/board-fsample.c:51: error: `KEY_SOFT1' undeclared
> here (not in a function)
> arch/arm/mach-omap1/board-fsample.c:51: error: initializer element is
> not constant
> arch/arm/mach-omap1/board-fsample.c:51: error: (near initialization for
> `fsample_keymap[12]')
> arch/arm/mach-omap1/board-fsample.c:55: error: `KEY_SHARP' undeclared
> here (not in a function)
> arch/arm/mach-omap1/board-fsample.c:55: error: initializer element is
> not constant
> arch/arm/mach-omap1/board-fsample.c:55: error: (near initialization for
> `fsample_keymap[16]')
> arch/arm/mach-omap1/board-fsample.c:56: error: `KEY_2_5' undeclared here
> (not in a function)
> arch/arm/mach-omap1/board-fsample.c:56: error: initializer element is
> not constant

Yes, fsample(omap850) is not properly maintained, but above
compilation error looks like easy to fix. Care to send a patch?

-- 
--Trilok Soni
