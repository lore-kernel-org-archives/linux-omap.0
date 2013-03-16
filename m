From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [PATCH 33/50] staging: omap-thermal: refactor APIs handling threshold
 values
Date: Sat, 16 Mar 2013 08:49:20 -0400
Message-ID: <51446A50.9070701@ti.com>
References: <1363352438-15935-1-git-send-email-eduardo.valentin@ti.com> <1363352438-15935-34-git-send-email-eduardo.valentin@ti.com> <20130316083952.GO9138@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20130316083952.GO9138@mwanda>
Sender: linux-pm-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 16-03-2013 04:39, Dan Carpenter wrote:
> On Fri, Mar 15, 2013 at 09:00:21AM -0400, Eduardo Valentin wrote:
>>   	if (ret) {
>>   		dev_err(bg_ptr->dev, "failed to read thot\n");
>> -		return -EIO;
>> +		ret = -EIO;
>> +		goto exit;
>>   	}
>>
>> -	*thot = temp;
>> +	*val = temp;
>>
>> +exit:
>>   	return 0;
>>   }
>
>
> The bunny hop has introduced a bug and this always returns success.

What was the bug introduced?

I will send a patch to fix the return value.

>
> regards,
> dan carpenter
>
>
>

