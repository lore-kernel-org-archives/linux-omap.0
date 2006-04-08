From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: patches for fsample/850
Date: Sat, 8 Apr 2006 04:00:36 -0700 (PDT)
Message-ID: <20060408110036.34284.qmail@web32904.mail.mud.yahoo.com>
References: <20060407220658.GA19801@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20060407220658.GA19801@localhost.localdomain>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Brian Swetland <swetland@google.com>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Brian Swetland <swetland@google.com> wrote:

> 
> Attached is a set of patches to start support for the omap850
> and specifically the f-sample development board from TI.
> 
> Features:
> 
> - machine ID 970 as registered with the arm machine registery:
>   http://www.arm.linux.org.uk/developer/machines/?action=list&id=970
> - initial support for the FPGA on fsample
> - adjustment to the 'p2' lcd driver so that it correctly initializes
>   the display on fsample (which involves using the FPGA interface)
> - some adjustment to clock.h/clock.c to avoid disabling the baseband
>   side of the world on 730/850 as a sideeffect of other clock changes

Are you using u-boot as bootloader and where you will make it
available?
Better place to put it is linux.omap.com.

> +obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o

Your patch is not having board-fsample.c.

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
