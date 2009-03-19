From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: BT656 Support and MMDC support on top of OMAP3EVM
Date: Thu, 19 Mar 2009 17:56:50 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940427CBFCEE@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-media-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-media-owner@vger.kernel.org
To: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "psp_video@list.ti.com - Video discussion list for PSP Video team (May
	contain non-TIers)" <psp_video@list.ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

I am getting some private requests for supporting BT656 and Multi-Media Daughter card on top of latest Kernel + Sakari's latest ISP-Camera patches/repository. So I am posting the patch supporting BT656 and MMDC support with all the review comments fixed (received from earlier posts).

Please note that, hence forth I will try to avoid submitting patches on top of V4L2-int framework. The next immediate activity would be migration to sub-device framework.

Sakari,

How about merging these patches (BT656 support patch) into your repository so that I don't have to maintain and re-submit the patches again and again. 

If you feel it should be done, then please let me know if you have any review comments I will try to fix immediately and provide you a patch.

The patches are following this mail.

Thanks,
Vaibhav Hiremath

