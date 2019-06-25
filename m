From: Tony Lindgren <tony@atomide.com>
Subject: nl80211 wlcore regression in next
Date: Tue, 25 Jun 2019 00:38:37 -0700
Message-ID: <20190625073837.GG5447@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@codeaurora.org>, Eyal Reizer <eyalreizer@gmail.com>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Looks like at least drivers/net/wireless/ti wlcore driver has stopped
working in Linux next with commit 901bb9891855 ("nl80211: require and
validate vendor command policy"). Reverting the commit above makes it
work again.

It fails with the warning below, any ideas what goes wrong?

Regards,

Tony

8< ----------------
WARNING: CPU: 0 PID: 21 at net/wireless/core.c:868 wiphy_register+0x85c/0xbd4 [cfg80211]
...
[<bf05f570>] (wiphy_register [cfg80211]) from [<bf121e08>] (ieee80211_register_hw+0x4e4/0xcd8 [mac80211])
[<bf121e08>] (ieee80211_register_hw [mac80211]) from [<bf33135c>] (wlcore_nvs_cb+0x758/0xabc [wlcore])
[<bf33135c>] (wlcore_nvs_cb [wlcore]) from [<c05c3770>] (request_firmware_work_func+0x50/0x8c)
[<c05c3770>] (request_firmware_work_func) from [<c0154bb8>] (process_one_work+0x20c/0x504)
...
