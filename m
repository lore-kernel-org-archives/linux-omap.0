From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH] drivers: video: omap2: dss: Use PTR_RET function
Date: Wed, 20 Mar 2013 13:02:28 -0500
Message-ID: <5149F9B4.2020400@ti.com>
References: <1363680194-10404-1-git-send-email-gheorghiuandru@gmail.com> <5149A3D0.2010902@ti.com> <5149D95D.2030505@ti.com> <5149EAE7.7040800@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5149EAE7.7040800@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alexandru Gheorghiu <gheorghiuandru@gmail.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On 03/20/2013 11:59 AM, Tomi Valkeinen wrote:
> On 2013-03-20 17:44, Jon Hunter wrote:
>>
>> On 03/20/2013 06:56 AM, Tomi Valkeinen wrote:
>>> On 2013-03-19 10:03, Alexandru Gheorghiu wrote:
>>>> Use PTR_RET function instead of IS_ERR and PTR_ERR.
>>>> Patch found using coccinelle.
>>>>
>>>> Signed-off-by: Alexandru Gheorghiu <gheorghiuandru@gmail.com>
>>>> ---
>>>>  drivers/video/omap2/dss/core.c |    5 +----
>>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
>>>> index f8779d4..60cc6fe 100644
>>>> --- a/drivers/video/omap2/dss/core.c
>>>> +++ b/drivers/video/omap2/dss/core.c
>>>> @@ -181,10 +181,7 @@ int dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
>>>>  	d = debugfs_create_file(name, S_IRUGO, dss_debugfs_dir,
>>>>  			write, &dss_debug_fops);
>>>>  
>>>> -	if (IS_ERR(d))
>>>> -		return PTR_ERR(d);
>>>> -
>>>> -	return 0;
>>>> +	return PTR_RET(d);
>>>>  }
>>>>  #else /* CONFIG_OMAP2_DSS_DEBUGFS */
>>>>  static inline int dss_initialize_debugfs(void)
>>>>
>>>
>>> Thanks. I'll apply to omapdss tree.
>>
>> Is this correct? If debugfs_create_file() returns a valid pointer, then
>> now dss_debugfs_create_file() will return a non-zero value on success. I
>> don't think this is what you want. A similar case came up recently here [1].
> 
> Hmm. I don't follow. And I don't understand the post where you referred.
> 
> PTR_RET is defined as:
> 
> if (IS_ERR(ptr))
>         return PTR_ERR(ptr);
> else
>         return 0;
> 
> How's that different from the original code?

Oops sorry, I missed that you were returning PTR_RET() and not
PTR_ERR(). Yes that looks fine. Sorry for the noise!

Jon
