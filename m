From: Daniel Jacobowitz <dan@debian.org>
Subject: Re: Problem using gdbserver on ARM target
Date: Thu, 4 May 2006 10:03:11 -0400
Message-ID: <20060504140311.GA32124@nevyn.them.org>
References: <OF2D51E9C2.3C3CCC6A-ON65257164.00424D70-65257164.00426D5F@flextronicssoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <OF2D51E9C2.3C3CCC6A-ON65257164.00424D70-65257164.00426D5F@flextronicssoftware.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Chetan Kapoor <chetan.kapoor@flextronicssoftware.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, linux-arm-toolchain@lists.arm.linux.org.uk
List-Id: linux-omap@vger.kernel.org

On Thu, May 04, 2006 at 05:35:23PM +0530, Chetan Kapoor wrote:
> A make is successful but the dynamically linked ARM executable gives the 
> following error when I execute it on the target,
> 
> ~ # ./gdbserver
> -sh: ./gdbserver: No such file or directory

Then your toolchain does not match your root file system.  Take a look
with readelf -d and readelf -l to see where this binary is searching
for libraries and for the dynamic loader.

> I have a prebuilt toolchain for which I do not have the source code, and 
> libthread_db.a is not present in the toolchain's lib folder, rather 
> libthread_db.so is present. Any pointers, where can I get the toolchain's 
> source and use it to build static librares?, which will in turn be useful 
> in building statically linked gdbserver.

It should be obvious that you haven't given us enough information to
answer this question.

The toolchain is all covered by the GPL.  It is (roughly speaking) the
responsibility of whoever you got it from to provide you the source
code.  Ask them.

-- 
Daniel Jacobowitz
CodeSourcery

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
