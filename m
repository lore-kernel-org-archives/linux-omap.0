From: Komal Shah <komal_shah802003@yahoo.com>
Subject: Re: Compiling 2.6.14 for OMAP1510 Innovator
Date: Wed, 15 Mar 2006 04:03:24 -0800 (PST)
Message-ID: <20060315120324.29557.qmail@web32908.mail.mud.yahoo.com>
References: <9343BE359FA4224CA72A94D8CC362C9C093656@edpc500.cedt.iisc.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9343BE359FA4224CA72A94D8CC362C9C093656@edpc500.cedt.iisc.ernet.in>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--- Prakash Narayanan M <mnarayan@cedt.iisc.ernet.in> wrote:

> Hai all
> 
>  
> 
> I am trying to compile kernel 2.6.14 with omap1 patch downloaded from
> muru.com. I am using 3.4.1 toolchain. I am facing the  following
> problem
> in compiling.  While compiling for OMAP15XX, I set
> "CONFIG_ARCH_OMAP16XX
> is not set" in .config.  Now the following warning/error comes in
> compiling.
> 

There is already 1510 innovator defconfig file available. Check
arch/arm/configs directory or try this

#make omap_innovator_1510_defconfig
#make 

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
