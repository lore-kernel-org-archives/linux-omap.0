From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] phy: core: Add phy_pm_runtime_enabled
Date: Mon, 19 Nov 2018 22:46:40 +0800
Message-ID: <201811192231.AFKyajiB%fengguang.wu@intel.com>
References: <20181117133755.9129-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181117133755.9129-2-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kbuild-all@01.org, Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tony,

I love your patch! Yet something to improve:

[auto build test ERROR on phy/next]
[also build test ERROR on v4.20-rc3 next-20181119]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tony-Lindgren/Improve-phy-mapphone-pm/20181119-222603
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
config: riscv-tinyconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from include/linux/usb/otg.h:13,
                    from include/linux/usb/of.h:12,
                    from drivers/usb/phy/of.c:9:
   include/linux/phy/phy.h: In function 'phy_pm_runtime_enabled':
>> include/linux/phy/phy.h:246:14: error: expected ';' before '}' token
     return false
                 ^
                 ;
    }
    ~             

vim +246 include/linux/phy/phy.h

   243	
   244	static inline bool phy_pm_runtime_enabled(struct phy *phy)
   245	{
 > 246		return false
   247	}
   248	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/04w6evG8XlLl3ft--
