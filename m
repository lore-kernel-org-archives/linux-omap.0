From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [balbi-usb:testing/next 57/84] drivers/usb/dwc3/dwc3-st.c:328:2:
 error: implicit declaration of function 'pinctrl_pm_select_sleep_state'
Date: Fri, 21 Oct 2016 14:15:55 +0200
Message-ID: <CACRpkda5isWVt2H9AvwjER24oBOdvS8M_yqaA5jxUi-aebdxLg@mail.gmail.com>
References: <201610171915.7Qg5kFu7%fengguang.wu@intel.com> <87funvry7k.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <87funvry7k.fsf@linux.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: kbuild test robot <fengguang.wu@intel.com>, "kbuild-all@01.org" <kbuild-all@01.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 17, 2016 at 1:50 PM, Felipe Balbi
<felipe.balbi@linux.intel.com> wrote:

> kbuild test robot <fengguang.wu@intel.com> writes:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
>> head:   4281ef86fae986e0a9bb553fb311fe6d8e039118
>> commit: 040f47e7330045feaa8c06bf2900db2eb2038e80 [57/84] usb: dwc3: Kconfig: allow all glues to build if COMPILE_TEST
>> config: blackfin-allmodconfig (attached as .config)
>> compiler: bfin-uclinux-gcc (GCC) 6.2.0
>> reproduce:
>>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 040f47e7330045feaa8c06bf2900db2eb2038e80
>>         # save the attached .config to linux build tree
>>         make.cross ARCH=blackfin
>>
>> All errors (new ones prefixed by >>):
>>
>>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_suspend':
>>>> drivers/usb/dwc3/dwc3-st.c:328:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
>>      pinctrl_pm_select_sleep_state(dev);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    drivers/usb/dwc3/dwc3-st.c: In function 'st_dwc3_resume':
>>>> drivers/usb/dwc3/dwc3-st.c:338:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
>>      pinctrl_pm_select_default_state(dev);
>>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    cc1: some warnings being treated as errors
>
> looks like a bug in <linux/pinctrl/consumer.h>. Something along the
> lines of below should be enough:

I don't think so, that include file looks pretty solid.

I think the actual problem is that dwc3-st.c doesn't
#include <linux/pinctrl/consumer.h> even if it is using the
functions from it.

Yours,
Linus Walleij
