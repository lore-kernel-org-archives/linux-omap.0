From: Will Deacon <will.deacon@arm.com>
Subject: Re: 3.12-rc1: no longer compiles for Nokia n900 (omap based)
Date: Thu, 19 Sep 2013 10:36:28 +0100
Message-ID: <20130919093627.GB24866@mudshark.cambridge.arm.com>
References: <20130919093002.GA23806@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20130919093002.GA23806@amd.pavel.ucw.cz>
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
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 19, 2013 at 10:30:02AM +0100, Pavel Machek wrote:
> Hi!
> 
> I get:
> 
>   CC      arch/arm/kernel/machine_kexec.o
> /tmp/ccCFXeXG.s: Assembler messages:
> /tmp/ccCFXeXG.s:217: Error: garbage following instruction -- `dsb
> nshst'
> /tmp/ccCFXeXG.s:225: Error: garbage following instruction -- `dsb nsh'
> make[1]: *** [arch/arm/kernel/suspend.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> 
> pavel@amd:/data/l/linux-n900$ arm-linux-gnueabi-gcc --version
> arm-linux-gnueabi-gcc (Debian 4.3.5-4) 4.3.5
> 
> Minimum required gcc is 3.2, so I'm safe.

Please check your binutils. >= 2.22 has been reported to work.

Will1
