From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: nl80211 wlcore regression in next
Date: Tue, 25 Jun 2019 10:56:39 +0200
Message-ID: <a863a74f-c6a9-b862-d17e-bc5f1dbe980a@broadcom.com>
References: <20190625073837.GG5447@atomide.com>
 <2570f4087d6e3356df34635a0380ec8ce06c9159.camel@sipsolutions.net>
 <20190625080019.GH5447@atomide.com>
 <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f74087fef1e554e0aeb82a6cec4113727487928.camel@sipsolutions.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>, Tony Lindgren <tony@atomide.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 6/25/2019 10:02 AM, Johannes Berg wrote:
> On Tue, 2019-06-25 at 01:00 -0700, Tony Lindgren wrote:
>> Hi,
>>
>> * Johannes Berg <johannes@sipsolutions.net> [190625 07:47]:
>>> On Tue, 2019-06-25 at 00:38 -0700, Tony Lindgren wrote:
>>>> Hi,
>>>>
>>>> Looks like at least drivers/net/wireless/ti wlcore driver has stopped
>>>> working in Linux next with commit 901bb9891855 ("nl80211: require and
>>>> validate vendor command policy"). Reverting the commit above makes it
>>>> work again.
>>>>
>>>> It fails with the warning below, any ideas what goes wrong?
>>>
>>> Oops. For some reason, I neglected to check the vendor command usage
>>> beyond hwsim.
>>>
>>> The patch below should work?
>>
>> Yeah thanks that fixes the issue for me:
>>
>> Tested-by: Tony Lindgren <tony@atomide.com>
> 
> Thanks, I'll drop that into my tree and hopefully will remember to send
> it on soon.

Hi Johannes,

By chance noticed the patch included brcmfmac. So I tried, but I get 
compile issue below. It is because ERR_PTR really is an inline function 
so that is not working. So also need to patch that. I left the extra 
braces around the error code although not strictly necessary.

Regards,
Arend
---
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 2d17e32..da8249b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4172,7 +4172,7 @@ struct sta_opmode_info {
         u8 rx_nss;
  };

-#define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)ERR_PTR(-ENODATA))
+#define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)(-ENODATA))

  /**
   * struct wiphy_vendor_command - vendor command definition


---8<--------------------------------------------------------------------
   CC [M]  drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.o
In file included from 
drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c:18:0:
./include/net/cfg80211.h:4175:29: error: initializer element is not constant
  #define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)ERR_PTR(-ENODATA))
                              ^
drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c:126:13: note: 
in expansion of macro \u2018VENDOR_CMD_RAW_DATA\u2019
    .policy = VENDOR_CMD_RAW_DATA,
              ^
./include/net/cfg80211.h:4175:29: note: (near initialization for 
\u2018brcmf_vendor_cmds[0].policy\u2019)
  #define VENDOR_CMD_RAW_DATA ((const struct nla_policy *)ERR_PTR(-ENODATA))
                              ^
drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.c:126:13: note: 
in expansion of macro \u2018VENDOR_CMD_RAW_DATA\u2019
    .policy = VENDOR_CMD_RAW_DATA,
              ^
make[3]: *** [drivers/net/wireless/broadcom/brcm80211/brcmfmac/vendor.o] 
Error 1
