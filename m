From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: Git tree broken for fsample
Date: Thu, 23 Aug 2007 21:11:57 +0530
Message-ID: <46CDAAC5.2050101@celunite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
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

Hi,
      I get the following errors when I try to compile the kernel for 
fsample.


arch/arm/mach-omap1/board-fsample.c:43: error: `KEY_CENTER' undeclared 
here (not in a function)
arch/arm/mach-omap1/board-fsample.c:43: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:43: error: (near initialization for 
`fsample_keymap[4]')
arch/arm/mach-omap1/board-fsample.c:44: error: `KEY_0_5' undeclared here 
(not in a function)
arch/arm/mach-omap1/board-fsample.c:44: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:44: error: (near initialization for 
`fsample_keymap[5]')
arch/arm/mach-omap1/board-fsample.c:45: error: `KEY_SOFT2' undeclared 
here (not in a function)
arch/arm/mach-omap1/board-fsample.c:45: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:45: error: (near initialization for 
`fsample_keymap[6]')
arch/arm/mach-omap1/board-fsample.c:51: error: `KEY_SOFT1' undeclared 
here (not in a function)
arch/arm/mach-omap1/board-fsample.c:51: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:51: error: (near initialization for 
`fsample_keymap[12]')
arch/arm/mach-omap1/board-fsample.c:55: error: `KEY_SHARP' undeclared 
here (not in a function)
arch/arm/mach-omap1/board-fsample.c:55: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:55: error: (near initialization for 
`fsample_keymap[16]')
arch/arm/mach-omap1/board-fsample.c:56: error: `KEY_2_5' undeclared here 
(not in a function)
arch/arm/mach-omap1/board-fsample.c:56: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:56: error: (near initialization for 
`fsample_keymap[17]')
arch/arm/mach-omap1/board-fsample.c:62: error: `KEY_HEADSETHOOK' 
undeclared here (not in a function)
arch/arm/mach-omap1/board-fsample.c:62: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:62: error: (near initialization for 
`fsample_keymap[23]')
arch/arm/mach-omap1/board-fsample.c:67: error: `KEY_STAR' undeclared 
here (not in a function)
arch/arm/mach-omap1/board-fsample.c:67: error: initializer element is 
not constant
arch/arm/mach-omap1/board-fsample.c:67: error: (near initialization for 
`fsample_keymap[28]')


How do I fix this ?

-- 
Vivek
