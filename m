From: "Arun KS" <arunks@mistralsolutions.com>
Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 20:39:07 +0530
Message-ID: <dfeb90390810070809r481f1a55wba410516bf2d1e9e@mail.gmail.com>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	 <20081007115450.GD19835@sirena.org.uk>
	 <dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	 <e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
	 <e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
	 <e762f7a90810070518r22dfa404s3f34f3ade79db7bf@mail.gmail.com>
	 <48EB6820.3090809@mistralsolutions.com>
	 <e762f7a90810070650q642aa05eu1f909e7898042ee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:45671 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbYJGPJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 11:09:10 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1975216tic.23
        for <linux-omap@vger.kernel.org>; Tue, 07 Oct 2008 08:09:07 -0700 (PDT)
In-Reply-To: <e762f7a90810070650q642aa05eu1f909e7898042ee6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

On Tue, Oct 7, 2008 at 7:20 PM, Jesslyn Abdul Salam
<jesslyn.abdulsalam@gmail.com> wrote:
> Not yet. Would please share what you have done to make it work ? Also when I
> tried to strace aplay , it keeps looking for a
> </share/alsa/cards/tlv320aic23.conf> file which is not there in the alsa-lib
> package. Any idea what goes in that file ?

CCing in l-o mailing list too.

I dont know about that file. I didnt face that issue.

This is what i did to make it working. I guess its some omap1 related issue.
This makes the omap_mcbsp_request(0) at boot time, instead of runtime.

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 3a4cc4b..6369703 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -151,8 +151,8 @@ static int omap_mcbsp_dai_startup(struct
snd_pcm_substream *substream)
        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
        int err = 0;

-       if (!cpu_dai->active)
-               err = omap_mcbsp_request(mcbsp_data->bus_id);
+//     if (!cpu_dai->active)
+//             err = omap_mcbsp_request(mcbsp_data->bus_id);

        return err;
 }
@@ -164,7 +164,7 @@ static void omap_mcbsp_dai_shutdown(struct
snd_pcm_substream *substream)
        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);

        if (!cpu_dai->active) {
-               omap_mcbsp_free(mcbsp_data->bus_id);
+//             omap_mcbsp_free(mcbsp_data->bus_id);
                mcbsp_data->configured = 0;
        }
 }
diff --git a/sound/soc/omap/osk5912.c b/sound/soc/omap/osk5912.c
index 9477d18..98f1566 100644
--- a/sound/soc/omap/osk5912.c
+++ b/sound/soc/omap/osk5912.c
@@ -209,6 +209,7 @@ static int __init osk_soc_init(void)
               (uint) clk_get_rate(tlv320aic23_mclk), CODEC_CLOCK,
               clk_get_usecount(tlv320aic23_mclk));

+       omap_mcbsp_request(0);

        return 0;
 err1:

>
> Regards
>
> Jesslyn
>
> On Tue, Oct 7, 2008 at 7:16 PM, Arun KS <arunks@mistralsolutions.com> wrote:
>
>> Jesslyn Abdul Salam wrote:
>>
>>> I got it working. I2C_BOARD_INFO macro was wrongly intialized. Instead of
>>> tlv320aic23 i had written tlvaic23. Thanks to Arun for pointing this error
>>>
>>>
>> Can you hear audio playing?
>> Because i had done some hack to make it working in 5912osk.
>> I want to know you are not facing it or not.
>>
>> Arun
>>
>>  Jesslyn Abdul Salam
>>>
>>>
>>> On Tue, Oct 7, 2008 at 5:36 PM, Jesslyn Abdul Salam <
>>> jesslyn.abdulsalam@gmail.com> wrote:
>>>
>>>
>>>
>>>> ---------- Forwarded message ----------
>>>> From: Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
>>>> Date: Tue, Oct 7, 2008 at 5:36 PM
>>>> Subject: Re: [alsa-devel] AIC23 SOC Driver on OSK5912
>>>> To: Arun KS <arunks@mistralsolutions.com>
>>>>
>>>>
>>>> Yes, it is there. but it shows as "tlv320aic23b" instead of "tlv320aic"
>>>> Will that be the reason ????
>>>>
>>>>
>>>>
>>>>
>>>> On Tue, Oct 7, 2008 at 5:32 PM, Arun KS <arunks@mistralsolutions.com
>>>> >wrote:
>>>>
>>>>
>>>>
>>>>> On Tue, Oct 7, 2008 at 5:24 PM, Mark Brown <broonie@sirena.org.uk>
>>>>> wrote:
>>>>>
>>>>>
>>>>>> On Tue, Oct 07, 2008 at 05:18:55PM +0530, Jesslyn Abdul Salam wrote:
>>>>>>
>>>>>>
>>>>>>
>>>>>>> I have been trying to use the AIC23 ALSA SoC driver for OSK5912 for
>>>>>>> the
>>>>>>>
>>>>>>>
>>>>>> past
>>>>>
>>>>>
>>>>>> few days. I got the driver patch from the linux-omap/alsa-devel mailing
>>>>>>> lists. The driver got compiled along just fine. But when the kernel
>>>>>>>
>>>>>>>
>>>>>> boots,
>>>>>
>>>>>
>>>>>> no sound cards have been listed.
>>>>>>>
>>>>>>>
>>>>>> CCing in Arun KS <arunks@mistralsolutions.com> who contributed that
>>>>>> support.
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Advanced Linux Sound Architecture Driver Version 1.0.17.
>>>>>>>          ASoC version
>>>>>>> 0.13.2
>>>>>>> AIC23 Audio Codec
>>>>>>> 0.1
>>>>>>> MCLK = 12000000 [12000000], usecount =
>>>>>>> 0
>>>>>>> ALSA device
>>>>>>> list:
>>>>>>>    No soundcards
>>>>>>> found.
>>>>>>>          Any one have tested this before ?
>>>>>>>
>>>>>>>
>>>>>> Can you check i2c?
>>>>>
>>>>> # cat /sys/bus/i2c/devices/1-001b/name
>>>>> tlv320aic23
>>>>>
>>>>>
>>>>>
>>>>>> _______________________________________________
>>>>>> Alsa-devel mailing list
>>>>>> Alsa-devel@alsa-project.org
>>>>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>>
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>>
>>>
>>>
>>
>>
>> Please do not print this email unless it is absolutely necessary. Spread
>> environmental awareness.
>>
>>
>> -------------------------------------------------------DISCLAIMER------------------------------------------------------
>> The information transmitted herewith is confidential and proprietary
>> information intended only for use by the individual or entity to which it is
>> addressed. If the reader of this message is not the intended recipient, you
>> are hereby notified that any review, retransmission, dissemination,
>> distribution, copying or other use of, or taking of any action in reliance
>> upon this information is strictly prohibited. If you have received this
>> communication in error, please contact the sender and delete the material
>> from your computer.
>>
>> --------------------------------------------------------------------------------------------------------------------------------
>>
>>
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
