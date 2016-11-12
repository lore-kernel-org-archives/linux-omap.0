From: Nicolae Rosia <nicolae.rosia.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] rtc: rtc-twl: cleanup
Date: Sat, 12 Nov 2016 12:23:08 +0200
Message-ID: <CAKP5S=1YeLRqun5ABjYRk=be1fVBGJPqo_nOC1oYmnguG0+jpg@mail.gmail.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBDL53MW2W4EBBDO3TPAQKGQE36MFOUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1478945246-32056-1-git-send-email-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Sat, Nov 12, 2016 at 12:07 PM, Nicolae Rosia
<Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:
> This is a cleanup and preparation of rtc-twl to reduce the usage of
> twl-core exported functions.
> The next patch series will further reduce the usage of exported functions
> but first it requires some changes in mfd/twl-core.c
Tony, could you please test this series again and add your Tested-By ?

Thanks a lot,
Nicolae

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
